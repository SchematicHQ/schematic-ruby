# frozen_string_literal: true

module Schematic
  module Credits
    module Types
      class ListBillingPlanCreditGrantsRequest < Internal::Types::Model
        field :credit_id, -> { String }, optional: true, nullable: false
        field :ids, -> { String }, optional: true, nullable: false
        field :plan_id, -> { String }, optional: true, nullable: false
        field :plan_ids, -> { String }, optional: true, nullable: false
        field :plan_version_id, -> { String }, optional: true, nullable: false
        field :limit, -> { Integer }, optional: true, nullable: false
        field :offset, -> { Integer }, optional: true, nullable: false
      end
    end
  end
end
