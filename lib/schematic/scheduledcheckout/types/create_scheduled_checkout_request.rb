# frozen_string_literal: true

module Schematic
  module Scheduledcheckout
    module Types
      class CreateScheduledCheckoutRequest < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :execute_after, -> { String }, optional: false, nullable: false
        field :from_plan_id, -> { String }, optional: false, nullable: false
        field :to_plan_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
