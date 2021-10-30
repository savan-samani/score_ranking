# frozen_string_literal: true

class ParameterMissingError < ApplicationError
  HTTP_STATUS_CODE = 400

  def errors_for_response
    [
      {
        message: i18n(:parameter_missing_error),
        code: ErrorCodes::BASE_VALIDATION_ERROR_CLIENT
      }
    ]
  end
end
