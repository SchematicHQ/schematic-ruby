# frozen_string_literal: true

module Schematic
  module Types
    class UserDetailResponseData < Internal::Types::Model
      field :company_memberships, -> { Internal::Types::Array[Schematic::Types::CompanyMembershipDetailResponseData] }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :entity_traits, -> { Internal::Types::Array[Schematic::Types::EntityTraitDetailResponseData] }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :keys, -> { Internal::Types::Array[Schematic::Types::EntityKeyDetailResponseData] }, optional: false, nullable: false
      field :last_seen_at, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :traits, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
