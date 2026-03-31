# frozen_string_literal: true

module Schematic
  module Types
    class EventResponseData < Internal::Types::Model
      field :api_key, -> { String }, optional: true, nullable: false
      field :body, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      field :body_preview, -> { String }, optional: false, nullable: false
      field :captured_at, -> { String }, optional: false, nullable: false
      field :company_id, -> { String }, optional: true, nullable: false
      field :enriched_at, -> { String }, optional: true, nullable: false
      field :environment_id, -> { String }, optional: true, nullable: false
      field :error_message, -> { String }, optional: true, nullable: false
      field :feature_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :loaded_at, -> { String }, optional: true, nullable: false
      field :processed_at, -> { String }, optional: true, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
      field :sent_at, -> { String }, optional: true, nullable: false
      field :status, -> { Schematic::Types::EventStatus }, optional: false, nullable: false
      field :subtype, -> { String }, optional: true, nullable: false
      field :type, -> { Schematic::Types::EventType }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: true, nullable: false
      field :user_id, -> { String }, optional: true, nullable: false
    end
  end
end
