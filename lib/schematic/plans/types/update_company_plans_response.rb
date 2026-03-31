# frozen_string_literal: true

module Schematic
  module Plans
    module Types
      class UpdateCompanyPlansResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::CompanyDetailResponseData }, optional: false, nullable: false
        field :params, -> { Internal::Types::Hash[String, Object] }, optional: false, nullable: false
      end
    end
  end
end
