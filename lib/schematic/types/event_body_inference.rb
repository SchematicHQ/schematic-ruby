# frozen_string_literal: true

module Schematic
  module Types
    class EventBodyInference < Internal::Types::Model
      field :cached_input_tokens, -> { Integer }, optional: true, nullable: false
      field :company, -> { Internal::Types::Hash[String, String] }, optional: false, nullable: false
      field :cost, -> { String }, optional: true, nullable: false
      field :currency, -> { String }, optional: true, nullable: false
      field :event, -> { String }, optional: true, nullable: false
      field :input_tokens, -> { Integer }, optional: false, nullable: false
      field :operation, -> { String }, optional: true, nullable: false
      field :output_tokens, -> { Integer }, optional: false, nullable: false
      field :provider, -> { String }, optional: false, nullable: false
      field :reasoning_tokens, -> { Integer }, optional: true, nullable: false
      field :request_model, -> { String }, optional: true, nullable: false
      field :requests, -> { Integer }, optional: true, nullable: false
      field :response_model, -> { String }, optional: false, nullable: false
      field :user, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
    end
  end
end
