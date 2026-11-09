# frozen_string_literal: true

module Schematic
  module Billing
    module Types
      class UploadContractDocumentRequest < Internal::Types::Model
        field :billing_profile_id, -> { String }, optional: false, nullable: false
      end
    end
  end
end
