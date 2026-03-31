# frozen_string_literal: true

module Schematic
  module Components
    module Types
      class PreviewComponentDataResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::ComponentPreviewResponseData }, optional: false, nullable: false
        field :params, -> { Schematic::Components::Types::PreviewComponentDataParams }, optional: false, nullable: false
      end
    end
  end
end
