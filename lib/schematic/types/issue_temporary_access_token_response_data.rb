# frozen_string_literal: true

module Schematic
  module Types
    class IssueTemporaryAccessTokenResponseData < Internal::Types::Model
      field :api_key_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :expired_at, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :resource_type, -> { String }, optional: false, nullable: false
      field :token, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
