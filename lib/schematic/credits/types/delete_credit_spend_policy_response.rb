# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Credits
    module Types
      class DeleteCreditSpendPolicyResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::DeleteResponse }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
