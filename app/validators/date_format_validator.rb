# frozen_string_literal: true

class DateFormatValidator < ActiveModel::EachValidator
  DATE_FORMAT = '%Y-%m-%d'

  def validate_each(record, attribute, value)
    Date.strptime(value, DATE_FORMAT) if value.is_a?(String)
  rescue Date::Error
    record.errors.add(attribute, options[:message] || :invalid)
  end
end
