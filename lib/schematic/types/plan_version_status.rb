# frozen_string_literal: true

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
