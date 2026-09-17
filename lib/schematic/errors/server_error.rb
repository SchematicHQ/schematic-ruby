# frozen_string_literal: true

module Schematic
  module Errors
    class ServerError < ResponseError
    end

    class ServiceUnavailableError < ResponseError
    end
  end
end
