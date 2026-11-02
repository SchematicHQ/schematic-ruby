# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Accounts
    module Types
      class GetWhoAmIResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::WhoAmIResponseData }, optional: false, nullable: false

        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
