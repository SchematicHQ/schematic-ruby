# frozen_string_literal: true

module Schematic
  module Types
    class UpdateCreditBundleRequestBody < Internal::Types::Model
      field :bundle_id, -> { String }, optional: false, nullable: false
      field :quantity, -> { Integer }, optional: false, nullable: false
    end
  end
end
