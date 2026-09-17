# frozen_string_literal: true

module Schematic
  module Credits
    module Leases
      # What a settle did locally, and what it owes the server.
      #
      # settled_locally is true when the hold was still open and this call
      # debited the consumed slice and refunded the rest. False when it had
      # already been swept at its TTL, already settled, or the store was
      # unreachable: the lease balance was not touched here, so it reads high
      # until the lease rolls over, and the event is a recovery emit.
      SettleOutcome = Struct.new(:track, :settled_locally, keyword_init: true)

      # Consume a reservation against its lease and build the event that bills
      # it.
      #
      # The event is built from the caller-held handle rather than the store, so
      # the usage is still billed once the hold has been swept. Only the local
      # bookkeeping clamps to the reserved amount; the event carries the
      # unclamped actual, because the server is the source of truth for real
      # consumption.
      def self.consume_reservation_and_build_event(reservations, reservation, actual_quantity, traits: nil)
        consumed = reservations.consume(reservation.id, actual_quantity * reservation.consumption_rate)
        SettleOutcome.new(
          track: build_reservation_track_event(reservation, actual_quantity, traits: traits),
          settled_locally: !consumed.nil?
        )
      end

      # Build the track event for a reservation from the handle alone, with no
      # store access, so the client can still bill the usage when the local
      # settle fails against an unreachable store.
      def self.build_reservation_track_event(reservation, actual_quantity, traits: nil)
        body = { event: reservation.event_subtype, quantity: actual_quantity }
        if reservation.server_mode?
          # The hold lives on the server, so the event settles it by id. Never
          # send lease_id too: the server prefers it when both are set, and
          # there is no lease here for it to route through.
          body[:reservation_id] = reservation.id
        else
          # Routes the server-side credit consumption through the lease's
          # sub-ledger instead of decrementing the grant again, which the
          # acquire already pre-debited. Without this the grant double-debits
          # and eventually starves redemptions mid-session.
          body[:lease_id] = reservation.lease_id
        end
        eval_ctx = reservation.eval_ctx || {}
        company = eval_ctx[:company] || eval_ctx["company"]
        user = eval_ctx[:user] || eval_ctx["user"]
        body[:company] = company if company && !company.empty?
        body[:user] = user if user && !user.empty?
        body[:traits] = traits if traits
        body
      end
    end
  end
end
