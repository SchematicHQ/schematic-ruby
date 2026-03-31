# frozen_string_literal: true

module Schematic
  module Checkout
    module Types
      class ManagePlanResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::ManagePlanResponseResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
