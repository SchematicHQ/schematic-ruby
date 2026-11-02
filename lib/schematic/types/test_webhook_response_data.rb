# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class TestWebhookResponseData < Internal::Types::Model
      field :failure_reason, -> { String }, optional: true, nullable: false

      field :response_code, -> { Integer }, optional: false, nullable: false

      field :success, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
