# frozen_string_literal: true

require "securerandom"
require "time"

module Schematic
  module Credits
    module Leases
      # What the server says a lease is after an acquire or an extend. It is
      # also what installs a lease into a store: the local balance is derived,
      # never supplied.
      LeaseGrant = Struct.new(:lease_id, :company_id, :credit_type_id, :granted_amount, :expires_at,
                              keyword_init: true)

      # The lease lifecycle over the generated API client. Separated from
      # LeaseManager so tests and the conformance runner can script the wire.
      #
      # Both calls take the client's default retry policy. Acquire is safe to
      # retry because the server hands back the slot's existing active lease
      # rather than opening a second one. An extend is an increment, so a retry
      # after a lost response would grant the tranche twice; the request carries
      # an idempotency key minted once per extend to collapse them.
      class ApiWireClient
        def initialize(credits_client:)
          @credits = credits_client
        end

        def acquire(company_id:, credit_type_id:, requested_amount:, expires_at:, request_options: {})
          response = @credits.acquire_credit_lease(
            request_options: request_options,
            company_id: company_id,
            credit_type_id: credit_type_id,
            # Rounded up, not to nearest: the API takes a whole number, and a
            # shortfall of 10.4 asked for as 10 leaves the retried reserve short
            # by the same fraction every time.
            requested_amount: Leases.wire_quantity(requested_amount),
            expires_at: expires_at.utc.iso8601
          )
          grant_from(response)
        end

        def extend(lease_id:, additional_amount:, expires_at:, idempotency_key: nil, request_options: {})
          body = {
            lease_id: lease_id,
            additional_amount: Leases.wire_quantity(additional_amount),
            expires_at: expires_at.utc.iso8601,
            # The key is minted once here, outside the retry loop, so every
            # attempt of this extend carries the same one and the server folds
            # them into a single increment. A caller that already minted one
            # keeps it: the manager does, so its single-flight followers settle
            # against the same key.
            idempotency_key: idempotency_key || SecureRandom.uuid
          }
          grant_from(@credits.extend_credit_lease(request_options: request_options, **body))
        end

        def release(lease_id:, request_options: {})
          @credits.release_credit_lease(request_options: request_options, lease_id: lease_id)
          nil
        end

        private

        def grant_from(response)
          data = response&.data
          raise "credit lease response carried no data" if data.nil?

          LeaseGrant.new(
            lease_id: data.id,
            company_id: data.company_id,
            credit_type_id: data.credit_type_id,
            granted_amount: data.granted_amount.to_f,
            expires_at: parse_time(data.expires_at)
          )
        end

        def parse_time(value)
          return value if value.is_a?(Time)

          Time.iso8601(value.to_s)
        end
      end
    end
  end
end
