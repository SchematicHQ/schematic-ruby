# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class GetOrCreateCompanyMembershipRequestBody < Internal::Types::Model
        field :company_id, -> { String }, optional: false, nullable: false
        field :user_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
