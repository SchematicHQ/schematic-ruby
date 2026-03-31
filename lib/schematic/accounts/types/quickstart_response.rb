# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class QuickstartResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::QuickstartResp }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
