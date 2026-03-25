# frozen_string_literal: true

module Schematic
  module Types
    class WhoAmIResponseData < Internal::Types::Model
      field :account_id, -> { String }, optional: false, nullable: false
      field :account_name, -> { String }, optional: false, nullable: false
      field :actor_type, -> { Schematic::Types::ActorType }, optional: false, nullable: false
      field :api_key_id, -> { String }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: true, nullable: false
      field :environments, -> { Internal::Types::Array[Schematic::Types::EnvironmentResponseData] }, optional: false, nullable: false
      field :stripe_user_id, -> { String }, optional: true, nullable: false
      field :user_id, -> { String }, optional: true, nullable: false
      field :user_name, -> { String }, optional: true, nullable: false
    end
  end
end
