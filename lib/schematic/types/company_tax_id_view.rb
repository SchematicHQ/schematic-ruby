# frozen_string_literal: true

module Schematic
  module Types
    class CompanyTaxIdView < Internal::Types::Model
      field :country, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :type, -> { String }, optional: false, nullable: false
      field :value, -> { String }, optional: false, nullable: false
      field :verification_status, -> { String }, optional: true, nullable: false
    end
  end
end
