# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class CompanyBillingProfileDocumentResponseData < Internal::Types::Model
      field :name, -> { String }, optional: false, nullable: false

      field :size, -> { Integer }, optional: false, nullable: false

      field :uploaded_at, -> { String }, optional: false, nullable: false
    end
  end
end
