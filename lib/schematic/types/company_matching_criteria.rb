# frozen_string_literal: true

module Schematic
  module Types
    module CompanyMatchingCriteria
      extend Schematic::Internal::Types::Enum

      BILLING_META_OBJECT = "billing_meta_object"
      MANUAL_UPSERT = "manual_upsert"
    end
  end
end
