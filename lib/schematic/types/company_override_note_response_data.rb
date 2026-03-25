# frozen_string_literal: true

module Schematic
  module Types
    class CompanyOverrideNoteResponseData < Internal::Types::Model
      field :created_at, -> { String }, optional: false, nullable: false
      field :external_user_id, -> { String }, optional: false, nullable: false
      field :external_user_name, -> { String }, optional: false, nullable: false
      field :id, -> { String }, optional: false, nullable: false
      field :note, -> { String }, optional: false, nullable: false
      field :updated_at, -> { String }, optional: false, nullable: false
    end
  end
end
