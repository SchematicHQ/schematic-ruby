# frozen_string_literal: true

module Schematic
  module Types
    class EventBodyFlagCheck < Internal::Types::Model
      field :company_id, -> { String }, optional: true, nullable: false
      field :error, -> { String }, optional: true, nullable: false
      field :flag_id, -> { String }, optional: true, nullable: false
      field :flag_key, -> { String }, optional: false, nullable: false
      field :reason, -> { String }, optional: false, nullable: false
      field :req_company, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :req_user, -> { Internal::Types::Hash[String, String] }, optional: true, nullable: false
      field :rule_id, -> { String }, optional: true, nullable: false
      field :user_id, -> { String }, optional: true, nullable: false
      field :value, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
