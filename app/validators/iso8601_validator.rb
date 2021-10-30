# frozen_string_literal: true

class Iso8601Validator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    Time.iso8601(value) if value.is_a?(String)
  rescue ArgumentError
    record.errors.add(attribute, options[:message] || :invalid)
  end
end
