# frozen_string_literal: true

module Schematic
  module Types
    class CreateFlagRequestBody < Internal::Types::Model
      field :default_value, -> { Internal::Types::Boolean }, optional: false, nullable: false
      field :description, -> { String }, optional: false, nullable: false
      field :feature_id, -> { String }, optional: true, nullable: false
      field :flag_type, -> { String }, optional: false, nullable: false
      field :key, -> { String }, optional: false, nullable: false
      field :maintainer_id, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
    end
  end
end
