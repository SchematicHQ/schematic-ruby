# frozen_string_literal: true

module Schematic
  module Types
    module ActorType
      extend Schematic::Internal::Types::Enum

      API_KEY = "api_key"
      APP_USER = "app_user"
      STRIPE_APP = "stripe_app"
      SYSTEM = "system"
      TEMPORARY_ACCESS_TOKEN = "temporary_access_token"
    end
  end
end
