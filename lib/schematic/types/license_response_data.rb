# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class LicenseResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false

      field :id, -> { String }, optional: false, nullable: false

      field :name, -> { String }, optional: false, nullable: false

      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
