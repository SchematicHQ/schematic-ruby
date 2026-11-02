# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    module MarkCustomPlanBillingPaidRequestBody
      # MarkCustomPlanBillingPaidRequestBody is an alias for Hash

      # @option str [String]
      #
      # @return [untyped]
      def self.load(str)
        ::JSON.parse(str)
      end

      # @option value [untyped]
      #
      # @return [String]
      def self.dump(value)
        ::JSON.generate(value)
      end
    end
  end
end
