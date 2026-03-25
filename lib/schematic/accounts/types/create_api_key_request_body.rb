# frozen_string_literal: true

module Schematic
  module Accounts
    module Types
      class CreateApiKeyRequestBody < Internal::Types::Model
        field :description, -> { String }, optional: true, nullable: false
        field :environment_id, -> { String }, optional: true, nullable: false
        field :name, -> { String }, optional: false, nullable: false
        field :readonly, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
