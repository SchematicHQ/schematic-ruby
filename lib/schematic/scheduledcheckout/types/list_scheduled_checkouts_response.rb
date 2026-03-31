# frozen_string_literal: true

module Schematic
  module Scheduledcheckout
    module Types
      class ListScheduledCheckoutsResponse < Internal::Types::Model
        field :data, -> { Internal::Types::Array[Schematic::Types::ScheduledCheckoutResponseData] }, optional: false, nullable: false
        field :params, -> { Schematic::Scheduledcheckout::Types::ListScheduledCheckoutsParams }, optional: false, nullable: false
      end
    end
  end
end
