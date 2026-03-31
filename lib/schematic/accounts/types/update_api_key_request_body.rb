# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class UpdateApiKeyRequestBody < Internal::Types::Model
        field :api_key_id, -> { String }, optional: false, nullable: false
        field :description, -> { String }, optional: true, nullable: false
        field :name, -> { String }, optional: true, nullable: false
      end
    end
  end
end
