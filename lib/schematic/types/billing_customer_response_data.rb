# frozen_string_literal: true

module Schematic
  module Types
    class BillingCustomerResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: true, nullable: false
      field :deleted_at, -> { String }, optional: true, nullable: false
      field :email, -> { String }, optional: false, nullable: false
      field :external_id, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :name, -> { String }, optional: false, nullable: false
      field :provider_type, -> { Schematic::Types::BillingProviderType }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
