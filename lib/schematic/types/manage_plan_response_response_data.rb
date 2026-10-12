# frozen_string_literal: true

module Schematic
  module Types
    class ManagePlanResponseResponseData < Internal::Types::Model
      field :checkout_id, -> { String }, optional: true, nullable: false

      field :company, -> { Schematic::Types::CompanyDetailResponseData }, optional: true, nullable: false

      field :problems, -> { Internal::Types::Array[Schematic::Types::CheckoutProblemResponseData] }, optional: false, nullable: false

      field :success, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
