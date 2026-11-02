# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module PlanVersionStatus
      extend Schematic::Internal::Types::Enum

      PUBLISHED = "published"
      DRAFT = "draft"
      ARCHIVED = "archived"
    end
  end
end
