# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      class GetOrCreateCompanyMembershipResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CompanyMembershipDetailResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
