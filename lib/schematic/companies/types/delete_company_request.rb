# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class DeleteCompanyRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :cancel_subscription, -> { Internal::Types::Boolean }, optional: true, nullable: false
        field :prorate, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
