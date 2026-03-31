# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class GetActiveCompanySubscriptionResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CompanySubscriptionResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::GetActiveCompanySubscriptionParams }, optional: false, nullable: false
      end
    end
  end
end
