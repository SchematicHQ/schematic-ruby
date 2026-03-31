# frozen_string_literal: true

module Schematic
  module Componentspublic
    module Types
      class GetPublicPlansResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::PublicPlansResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
