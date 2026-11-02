# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class EventBodyIdentify < Internal::Types::Model
      field :company, -> { Schematic::Types::EventBodyIdentifyCompany }, optional: true, nullable: false

      field :keys, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false

      field :name, -> { String }, optional: true, nullable: false

      field :traits, -> { Internal::Types::Hash[String, Object] }, optional: true, nullable: false
    end
  end
end
