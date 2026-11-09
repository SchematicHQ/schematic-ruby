# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class GroupRolloutChangeResponseData < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false

      field :name, -> { String }, optional: false, nullable: false
    end
  end
end
