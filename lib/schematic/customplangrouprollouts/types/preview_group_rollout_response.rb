# frozen_string_literal: true

require_relative "../../../schematic"

module Schematic
  module Customplangrouprollouts
    module Types
      class PreviewGroupRolloutResponse < Internal::Types::Model
        field :data, -> { Schematic::Types::GroupRolloutPreviewResponseData }, optional: false, nullable: false

        field :params, -> { Schematic::Customplangrouprollouts::Types::PreviewGroupRolloutParams }, optional: false, nullable: false
      end
    end
  end
end
