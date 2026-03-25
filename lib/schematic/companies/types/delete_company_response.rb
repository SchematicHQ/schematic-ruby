# frozen_string_literal: true

module Schematic
  module Companies
    module Types
      class DeleteCompanyResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::DeleteResponse }, optional: false, nullable: false
        field :params, -> { Schematic::Companies::Types::DeleteCompanyParams }, optional: false, nullable: false
      end
    end
  end
end
