# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PublishPreviewIntervalChangeResponseData < Internal::Types::Model
      field :from, -> { String }, optional: false, nullable: false

      field :to, -> { String }, optional: false, nullable: false
    end
  end
end
