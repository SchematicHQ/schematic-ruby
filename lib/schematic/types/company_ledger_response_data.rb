# frozen_string_literal: true

module Schematic
  module Types
    class CompanyLedgerResponseData < Internal::Types::Model
      field :id, -> { String }, optional: false, nullable: false
      field :logo_url, -> { String }, optional: true, nullable: false
      field :name, -> { String }, optional: false, nullable: false
    end
  end
end
