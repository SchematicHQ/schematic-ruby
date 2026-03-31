# frozen_string_literal: true

module Schematic
  module Types
    class ComponentResponseData < Internal::Types::Model
      field :ast, -> { Internal::Types::Hash[String, Integer] }, optional: true, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :state, -> { Schematic::Types::ComponentState }, optional: false, nullable: false
      field :type, -> { Schematic::Types::ComponentEntityType }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
