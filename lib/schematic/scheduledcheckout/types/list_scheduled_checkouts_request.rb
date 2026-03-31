# frozen_string_literal: true

module Schematic
  module Scheduledcheckout
    module Types
      class ListScheduledCheckoutsRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: true, nullable: false
        field :status, -> { Schematic::Types::ScheduledCheckoutStatus }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
