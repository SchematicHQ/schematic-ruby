# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class CountCreditBundlesRequest < Internal::Types::Model
        field :ids, -> { String }, optional: true, nullable: false
        field :credit_id, -> { String }, optional: true, nullable: false
        field :status, -> { Schematic::Types::BillingCreditBundleStatus }, optional: true, nullable: false
        field :bundle_type, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
