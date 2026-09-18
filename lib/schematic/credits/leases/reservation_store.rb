# frozen_string_literal: true

module Schematic
  module Credits
    module Leases
      # Per-process reservation table, paired with a sweep loop that returns
      # expired reservations to their underlying lease.
      #
      # For cross-process deployments use RedisReservationStore instead: both
      # answer the same calls with the same semantics.
      class ReservationStore
        def initialize(lease_store, sweep_interval_ms = DEFAULT_SWEEP_INTERVAL_MS, clock: DEFAULT_CLOCK,
                       logger: nil)
          @lease_store = lease_store
          @sweep_interval_ms = sweep_interval_ms
          @clock = clock
          @logger = logger
          @reservations = {}
          @mutex = Mutex.new
          @sweep_thread = nil
          @stopped = false
        end

        # Register a new reservation. Idempotent on id. It does NOT debit the
        # lease: the debit already happened in try_reserve, and recording the
        # hold after the debit is what bounds a crash between them to leaked
        # credits rather than a double spend.
        def add(reservation)
          @mutex.synchronize { @reservations[reservation.id] = reservation }
          nil
        end

        def get(id)
          @mutex.synchronize { @reservations[id] }
        end

        # Sum the open reservations for a (company, credit). A reservation
        # counts while it is in the table: its credits stay carved out of the
        # lease's local_remaining_credits until consume or sweep_expired removes
        # it and refunds the unspent remainder in the same step, so
        # local_remaining_credits + reserved_credits stays exact.
        def reserved_credits(company_id, credit_type_id)
          @mutex.synchronize do
            @reservations.each_value.sum do |reservation|
              if reservation.company_id == company_id && reservation.credit_type_id == credit_type_id
                reservation.credits_reserved
              else
                0
              end
            end
          end
        end

        # Claim a reservation exactly once and settle it: the clamped consumed
        # slice stays debited and the unspent remainder is refunded to the
        # lease. Returns the clamped figure, or nil when the reservation was
        # already gone (swept at its TTL, or claimed by a racing caller).
        #
        # The claim is the arbiter. A crash between the claim and the refund
        # leaks the unspent slice until the lease expires, which is the safe
        # direction: a second claim finds nothing and refunds nothing.
        def consume(id, credits_consumed)
          reservation = @mutex.synchronize { @reservations.delete(id) }
          return nil if reservation.nil?

          actual = credits_consumed.clamp(0, reservation.credits_reserved)
          refund = reservation.credits_reserved - actual
          if refund.positive?
            # Pinned to the originating lease: if that lease has expired and a
            # successor holds the slot, the refund is dropped, because the
            # expired lease's remainder was already returned server-side.
            @lease_store.refund(reservation.company_id, reservation.credit_type_id, refund, reservation.lease_id)
          end
          actual
        end

        # Start the background sweep loop. Safe to call repeatedly.
        def start_sweep
          @mutex.synchronize do
            return if @sweep_thread || @stopped

            interval = @sweep_interval_ms.to_f / 1000.0
            @sweep_thread = Thread.new do
              loop do
                sleep(interval)
                break if @stopped

                begin
                  sweep_expired
                rescue StandardError => e
                  # Keep the loop alive: a store blip must not stop the sweeper.
                  @logger&.debug("Reservation sweep failed: #{e.message}")
                end
              end
            end
            @sweep_thread.abort_on_exception = false
          end
        end

        # Remove every reservation past its TTL and refund its full hold to its
        # lease. Returns the number swept.
        def sweep_expired(now = nil)
          now ||= @clock.call
          expired = @mutex.synchronize do
            due = @reservations.each_value.select { |r| r.expires_at.to_f <= now.to_f }
            due.each { |r| @reservations.delete(r.id) }
            due
          end
          expired.each do |reservation|
            @lease_store.refund(
              reservation.company_id,
              reservation.credit_type_id,
              reservation.credits_reserved,
              reservation.lease_id
            )
          end
          expired.size
        end

        def stop
          thread = @mutex.synchronize do
            @stopped = true
            thread = @sweep_thread
            @sweep_thread = nil
            thread
          end
          return nil if thread.nil?

          # A sweep past its claim has deleted the reservation but not yet
          # refunded the lease, and killing it there strands the unspent slice
          # until the lease expires. Give it a bounded moment to land that
          # refund, then kill: the loop checks @stopped as soon as its sleep
          # ends, so a parked sweeper costs at most this wait.
          thread.kill unless thread.join(SWEEP_STOP_JOIN_MS / 1000.0)
          nil
        end

        def size
          @mutex.synchronize { @reservations.size }
        end
      end
    end
  end
end
