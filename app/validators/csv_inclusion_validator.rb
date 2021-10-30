# frozen_string_literal: true

class CsvInclusionValidator < ActiveModel::Validations::InclusionValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    value.split(',').each do |v|
      super(record, attribute, v.to_sym)
    end
  end
end
