# frozen_string_literal: true

module Schematic
  module Accesstokens
    module Types
      class IssueTemporaryAccessTokenResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::IssueTemporaryAccessTokenResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
