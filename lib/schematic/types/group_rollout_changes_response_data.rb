# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class GroupRolloutChangesResponseData < Internal::Types::Model
      field :credit_grants_added, -> { Internal::Types::Array[Schematic::Types::GroupRolloutChangeResponseData] }, optional: false, nullable: false

      field :credit_grants_changed, -> { Internal::Types::Array[Schematic::Types::GroupRolloutChangeResponseData] }, optional: false, nullable: false

      field :credit_grants_removed, -> { Internal::Types::Array[Schematic::Types::GroupRolloutChangeResponseData] }, optional: false, nullable: false

      field :entitlements_added, -> { Internal::Types::Array[Schematic::Types::GroupRolloutChangeResponseData] }, optional: false, nullable: false

      field :entitlements_changed, -> { Internal::Types::Array[Schematic::Types::GroupRolloutChangeResponseData] }, optional: false, nullable: false

      field :entitlements_removed, -> { Internal::Types::Array[Schematic::Types::GroupRolloutChangeResponseData] }, optional: false, nullable: false

      field :price_changed, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
