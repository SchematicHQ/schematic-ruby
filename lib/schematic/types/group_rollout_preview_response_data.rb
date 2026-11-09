# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class GroupRolloutPreviewResponseData < Internal::Types::Model
      field :changes, -> { Schematic::Types::GroupRolloutChangesResponseData }, optional: true, nullable: false

      field :companies, -> { Internal::Types::Array[Schematic::Types::GroupRolloutCompanyResponseData] }, optional: false, nullable: false

      field :from_plan_version_id, -> { String }, optional: false, nullable: false

      field :payer_company_id, -> { String }, optional: false, nullable: false

      field :to_plan_version_id, -> { String }, optional: false, nullable: false
    end
  end
end
