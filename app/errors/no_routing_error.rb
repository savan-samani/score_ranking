# frozen_string_literal: true

class NoRoutingError < ApplicationError
  HTTP_STATUS_CODE = 404

  attr_reader :path

  def initialize(path:)
    super()
    @path = path
  end

  def errors_for_response
    [
      {
        code: ErrorCodes::NO_ROUTING,
        message: "No routing: #{path}"
      }
    ]
  end
end
