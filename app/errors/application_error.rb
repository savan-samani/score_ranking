# frozen_string_literal: true

class ApplicationError
  # NOTE: If you do not overwrite this constant, you will get a 500 error
  HTTP_STATUS_CODE = 500

  def http_status_code
    self.class.const_get(:HTTP_STATUS_CODE)
  end

  def errors_for_response
    raise NotImplementedError, "You must implement #{self.class}##{__method__}"
  end

  def error_logs(exception)
    backtrace = exception.backtrace.join(";\n")
    "#{self.class}: #{exception.class}: \"#{exception.message}\": #{backtrace}"
  end

  protected

  def i18n(key, **params)
    I18n.t("errors.messages.#{key}", default: key.to_s, **params)
  end
end
