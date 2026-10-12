# frozen_string_literal: true

module Schematic
  module Types
    class UserCreditUsageResponseData < Internal::Types::Model
      field :billing_credit_id, -> { String }, optional: false, nullable: false

      field :credit_name, -> { String }, optional: false, nullable: false

      field :credits_used, -> { Float }, optional: false, nullable: false

      field :share, -> { Float }, optional: false, nullable: false

      field :user, -> { Schematic::Types::UserResponseData }, optional: true, nullable: false

      field :user_id, -> { String }, optional: true, nullable: false
    end
  end
end
