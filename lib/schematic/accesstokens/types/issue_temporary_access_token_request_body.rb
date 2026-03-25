# frozen_string_literal: true

module Schematic
  module Accesstokens
    module Types
      class IssueTemporaryAccessTokenRequestBody < Internal::Types::Model
        field :lookup, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
        field :resource_type, -> { String }, optional: false, nullable: false
      end
    end
  end
end
