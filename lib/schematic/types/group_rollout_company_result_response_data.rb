# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class GroupRolloutCompanyResultResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false

      field :error, -> { String }, optional: true, nullable: false

      field :plan_id, -> { String }, optional: true, nullable: false

      field :plan_version_id, -> { String }, optional: true, nullable: false

      field :status, -> { String }, optional: false, nullable: false
    end
  end
end
