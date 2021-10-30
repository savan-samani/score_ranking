# frozen_string_literal: true

class RecordNotFoundError < ApplicationError
  HTTP_STATUS_CODE = 404

  def errors_for_response
    [
      {
        message: i18n(:record_not_found),
        code: ErrorCodes::RECORD_NOT_FOUND
      }
    ]
  end
end
