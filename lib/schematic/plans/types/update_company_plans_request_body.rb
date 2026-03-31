# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class UpdateCompanyPlansRequestBody < Internal::Types::Model
        field :company_plan_id, -> { String }, optional: false, nullable: false
        field :add_on_ids, -> { Internal::Types::Array[String] }, optional: false, nullable: false
        field :base_plan_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
