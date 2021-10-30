# frozen_string_literal: true

class InternalServerError < ApplicationError
  attr_reader :request_id

  def initialize(request_id:)
    super()
    @request_id = request_id
  end

  def errors_for_response
    [
      {
        message: i18n(:internal_server_error, error_id: @request_id),
        code: ErrorCodes::BASE_SERVER_ERROR_OTHERS
      }
    ]
  end
end
