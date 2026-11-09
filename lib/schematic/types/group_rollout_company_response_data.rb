# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class GroupRolloutCompanyResponseData < Internal::Types::Model
      field :company, -> { Schematic::Types::CompanyResponseData }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: true, nullable: false

      field :reason, -> { String }, optional: true, nullable: false
    end
  end
end
