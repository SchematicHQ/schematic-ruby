# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class GetUserUsageByCompanyResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::UserUsageByCompanyResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Entitlements::Types::GetUserUsageByCompanyParams }, optional: false, nullable: false
      end
    end
  end
end
