# frozen_string_literal: true

module Schematic
  module Scheduledcheckout
    module Types
      class CreateScheduledCheckoutResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::ScheduledCheckoutResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
