# frozen_string_literal: true

module Schematic
  module Types
    class ActivityEntryResponseData < Internal::Types::Model
      field :actor_name, -> { String }, optional: false, nullable: false
      field :method_, -> { String }, optional: false, nullable: false, api_name: "method"
      field :resource_name, -> { String }, optional: false, nullable: false
      field :resource_type, -> { String }, optional: false, nullable: false
      field :timestamp, -> { String }, optional: false, nullable: false
      field :title, -> { String }, optional: false, nullable: false
    end
  end
end
