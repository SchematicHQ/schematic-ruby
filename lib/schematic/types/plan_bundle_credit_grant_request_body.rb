# frozen_string_literal: true

module Schematic
  module Types
    class PlanBundleCreditGrantRequestBody < Internal::Types::Model
      field :action, -> { Schematic::Types::PlanBundleAction }, optional: false, nullable: false
      field :create_req, -> { Schematic::Types::CreateBillingPlanCreditGrantRequestBody }, optional: true, nullable: false
      field :credit_grant_id, -> { String }, optional: true, nullable: false
      field :delete_req, -> { Schematic::Types::DeleteBillingPlanCreditGrantRequestBody }, optional: true, nullable: false
      field :update_req, -> { Schematic::Types::UpdateBillingPlanCreditGrantRequestBody }, optional: true, nullable: false
    end
  end
end
