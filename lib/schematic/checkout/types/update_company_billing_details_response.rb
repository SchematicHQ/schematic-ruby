# frozen_string_literal: true

module Schematic
  module Checkout
    module Types
      class UpdateCompanyBillingDetailsResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CompanyBillingDetailsResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
