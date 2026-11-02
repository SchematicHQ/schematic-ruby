# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module SubscriptionChangeAction
      extend Schematic::Internal::Types::Enum

      ADD = "add"
      CANCEL = "cancel"
      REMOVE = "remove"
      REPLACE = "replace"
    end
  end
end
