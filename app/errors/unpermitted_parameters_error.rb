# frozen_string_literal: true

class UnpermittedParametersError < ApplicationError
  HTTP_STATUS_CODE = 400

  def errors_for_response
    [
      {
        message: i18n(:unpermitted_parameter_error),
        code: ErrorCodes::BASE_VALIDATION_ERROR_CLIENT
      }
    ]
  end
end
