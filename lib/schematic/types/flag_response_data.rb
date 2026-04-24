# frozen_string_literal: true

module Schematic
  module Types
    class FlagResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :default_value, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :feature_id, -> { String }, optional: true, nullable: false
      field :flag_type, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :key, -> { String }, optional: false, nullable: false
      field :maintainer_account_member_id, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
