# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class PreviewSubscriptionUpcomingInvoiceLineItems < Internal::Types::Model
      field :amount, -> { Integer }, optional: false, nullable: false

      field :description, -> { String }, optional: false, nullable: false

      field :price_id, -> { String }, optional: false, nullable: false

      field :proration, -> { Internal::Types::Boolean }, optional: false, nullable: false

      field :quantity, -> { Integer }, optional: false, nullable: false
    end
  end
end
