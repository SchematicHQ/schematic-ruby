# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CatalogCreditBundleIDsResponseData < Internal::Types::Model
      field :credit_bundle_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
    end
  end
end
