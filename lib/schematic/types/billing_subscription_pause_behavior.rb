# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module BillingSubscriptionPauseBehavior
      extend Schematic::Internal::Types::Enum

      KEEP_AS_DRAFT = "keep_as_draft"
      MARK_UNCOLLECTIBLE = "mark_uncollectible"
      VOID = "void"
    end
  end
end
