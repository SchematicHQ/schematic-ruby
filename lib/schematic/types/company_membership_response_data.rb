# frozen_string_literal: true

module Schematic
  module Types
    class CompanyMembershipResponseData < Internal::Types::Model
      field :company_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :user_id, -> { String }, optional: false, nullable: false
    end
  end
end
