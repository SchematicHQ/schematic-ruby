# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class GetBillingEntityChildSubscriptionsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::CompanyBillingEntitySubscriptionResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::GetBillingEntityChildSubscriptionsParams }, optional: false, nullable: false
      end
    end
  end
end
