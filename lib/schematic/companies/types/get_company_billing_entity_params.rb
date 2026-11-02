# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Companies
    module Types
      # Input parameters
      class GetCompanyBillingEntityParams < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
