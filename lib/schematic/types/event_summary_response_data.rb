# frozen_string_literal: true

module Schematic
  module Types
    class EventSummaryResponseData < Internal::Types::Model
      field :company_count, -> { Integer }, optional: false, nullable: false
      field :environment_id, -> { String }, optional: false, nullable: false
      field :event_count, -> { Integer }, optional: false, nullable: false
      field :event_subtype, -> { String }, optional: false, nullable: false
      field :last_seen_at, -> { String }, optional: true, nullable: false
      field :user_count, -> { Integer }, optional: false, nullable: false
    end
  end
end
