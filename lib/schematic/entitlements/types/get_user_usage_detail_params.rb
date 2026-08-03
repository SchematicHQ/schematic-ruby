# frozen_string_literal: true

module Schematic
  module Entitlements
    module Types
      # Input parameters
      class GetUserUsageDetailParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :end_time, -> { String }, optional: true, nullable: false
        field :start_time, -> { String }, optional: true, nullable: false
        field :user_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
