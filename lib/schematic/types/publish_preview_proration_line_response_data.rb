# frozen_string_literal: true

module Schematic
  module Types
    class PublishPreviewProrationLineResponseData < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false

      field :description, -> { String }, optional: false, nullable: false

      field :period_end, -> { String }, optional: false, nullable: false

      field :period_start, -> { String }, optional: false, nullable: false

      field :price_external_id, -> { String }, optional: true, nullable: false

      field :quantity, -> { Integer }, optional: false, nullable: false
    end
  end
end
