# frozen_string_literal: true

module Schematic
  module Components
    module Types
      class PreviewComponentDataRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :component_id, -> { String }, optional: true, nullable: false
      end
    end
  end
end
