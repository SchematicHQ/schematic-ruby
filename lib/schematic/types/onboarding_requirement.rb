# frozen_string_literal: true

module Schematic
  module Types
    module OnboardingRequirement
      extend Schematic::Internal::Types::Enum

      CONNECT_AGENT = "connect_agent"
      CONNECT_BILLING = "connect_billing"
      CREATE_API_KEY = "create_api_key"
      FIRST_FLAG_CHECK = "first_flag_check"
      IMPORT_COMPANIES = "import_companies"
      MODEL_PACKAGING = "model_packaging"
      SEND_EVENTS = "send_events"
    end
  end
end
