# frozen_string_literal: true

module Schematic
  module Types
    class CatalogCreditBundleIDsResponseData < Internal::Types::Model
      field :credit_bundle_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
    end
  end
end
