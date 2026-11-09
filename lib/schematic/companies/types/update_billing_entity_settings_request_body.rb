# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class UpdateBillingEntitySettingsRequestBody < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false

        field :children_may_change_plan, -> { Internal::Types::Boolean }, optional: true, nullable: false
      end
    end
  end
end
