# frozen_string_literal: true

module Schematic
  module Types
    class UserUsageByCompanyResponseData < Internal::Types::Model
      field :credits, -> { Internal::Types::Array[Schematic::Types::UserCreditUsageResponseData] }, optional: false, nullable: false

      field :end_time, -> { String }, optional: false, nullable: false

      field :rows, -> { Internal::Types::Array[Schematic::Types::UserFeatureUsageResponseData] }, optional: false, nullable: false

      field :start_time, -> { String }, optional: false, nullable: false
    end
  end
end
