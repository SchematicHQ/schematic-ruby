# frozen_string_literal: true

module Schematic
  module Customplangrouprollouts
    module Types
      class CopyCustomPlanRequestBody < Internal::Types::Model
        field :plan_id, -> { String }, optional: false, nullable: false

        field :company_id, -> { String }, optional: false, nullable: false

        field :name, -> { String }, optional: true, nullable: false
      end
    end
  end
end
