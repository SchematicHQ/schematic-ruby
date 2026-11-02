# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PlanIssueResponseData < Internal::Types::Model
      field :code, -> { String }, optional: false, nullable: false

      field :description, -> { String }, optional: false, nullable: false

      field :detail, -> { String }, optional: true, nullable: false

      field :id, -> { String }, optional: true, nullable: false
    end
  end
end
