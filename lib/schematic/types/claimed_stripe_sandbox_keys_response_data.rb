# frozen_string_literal: true

module Schematic
  module Types
    class ClaimedStripeSandboxKeysResponseData < Internal::Types::Model
      field :publishable, -> { String }, optional: false, nullable: false

      field :sandbox_id, -> { String }, optional: false, nullable: false

      field :secret, -> { String }, optional: false, nullable: false
    end
  end
end
