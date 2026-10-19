# frozen_string_literal: true

module Schematic
  module Types
    class PublishPreviewPayInAdvanceResponseData < Internal::Types::Model
      field :committed_quantity, -> { Integer }, optional: false, nullable: false

      field :current_quantity, -> { Integer }, optional: true, nullable: false

      field :effective_quantity, -> { Integer }, optional: false, nullable: false

      field :feature_id, -> { String }, optional: false, nullable: false
    end
  end
end
