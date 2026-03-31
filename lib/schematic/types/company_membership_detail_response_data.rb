# frozen_string_literal: true

module Schematic
  module Types
    class CompanyMembershipDetailResponseData < Internal::Types::Model
      field :company, -> { Schematic::Types::CompanyResponseData }, optional: true, nullable: false
      field :company_id, -> { String }, optional: false, nullable: false
      field :created_at, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
      field :user_id, -> { String }, optional: false, nullable: false
    end
  end
end
