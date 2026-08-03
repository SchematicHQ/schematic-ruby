# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      class GetUserUsageByCompanyRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :end_time, -> { String }, optional: true, nullable: false
        field :feature_id, -> { String }, optional: true, nullable: false
        field :start_time, -> { String }, optional: true, nullable: false
      end
    end
  end
end
