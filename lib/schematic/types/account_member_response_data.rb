# frozen_string_literal: true

module Schematic
  module Types
    class AccountMemberResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :email, -> { String }, optional: true, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :image_url, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: true, nullable: false
      field :permissions, -> { Internal::Types::Hash[String, Internal::Types::Array[Schematic::Types::AccountMemberPermission]] }, optional: false, nullable: false
      field :role, -> { Schematic::Types::AccountMemberRole }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
