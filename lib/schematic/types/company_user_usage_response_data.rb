# frozen_string_literal: true

module Schematic
  module Types
    class CompanyUserUsageResponseData < Internal::Types::Model
      field :end_time, -> { String }, optional: false, nullable: false

      field :rows, -> { Internal::Types::Array[Schematic::Types::CompanyUserUsageRowResponseData] }, optional: false, nullable: false

      field :start_time, -> { String }, optional: false, nullable: false

      field :top_user_share, -> { Integer }, optional: false, nullable: false

      field :total, -> { Integer }, optional: false, nullable: false

      field :unattributed, -> { Schematic::Types::CompanyUserUsageRowResponseData }, optional: true, nullable: false
    end
  end
end
