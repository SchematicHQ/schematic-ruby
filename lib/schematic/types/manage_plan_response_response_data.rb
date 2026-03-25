# frozen_string_literal: true

module Schematic
  module Types
    class ManagePlanResponseResponseData < Internal::Types::Model
      field :company, -> { Schematic::Types::CompanyDetailResponseData }, optional: true, nullable: false
      field :success, -> { Internal::Types::Boolean }, optional: false, nullable: false
    end
  end
end
