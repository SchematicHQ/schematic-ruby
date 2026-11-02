# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Billing
    module Types
      class ListCompanyBillingProfilesResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CompanyBillingProfileResponseData] }, optional: false, nullable: false

        field :params, -> { Schematic::Billing::Types::ListCompanyBillingProfilesParams }, optional: false, nullable: false
      end
    end
  end
end
