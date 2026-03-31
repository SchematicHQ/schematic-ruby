# frozen_string_literal: true

module Schematic
  module Types
    class DatastreamCompanyPlan < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :trial_end_date, -> { String }, optional: true, nullable: false
    end
  end
end
