# frozen_string_literal: true

require_relative "../../schematic"

module Schematic
  module Types
    class StripeSandboxClaimLink < Internal::Types::Model
      field :claim_url, -> { String }, optional: false, nullable: false

      field :expires_at, -> { String }, optional: true, nullable: false

      field :sandbox_id, -> { String }, optional: false, nullable: false

      field :status, -> { String }, optional: false, nullable: false
    end
  end
end
