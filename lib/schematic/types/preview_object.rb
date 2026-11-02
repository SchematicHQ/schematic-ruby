# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PreviewObject < Internal::Types::Model
      field :description, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :image_url, -> { String }, optional: true, nullable: false

      field :name, -> { String }, optional: false, nullable: false
    end
  end
end
