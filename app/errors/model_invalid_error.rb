# frozen_string_literal: true

# This class automatically translates model validation errors
# into readable JSON: (e.g: ActiveModel::Model / ActiveModel::Validations)
class ModelInvalidError < ApplicationError
  HTTP_STATUS_CODE = 400

  attr_reader :model

  # Used to render json response
  # e.g:
  # if object.save
  #   ...
  # else
  #   render ModelInvalidError.to_response(object)
  # end

  def self.to_response(model)
    error = ModelInvalidError.new(model: model)

    {
      json: {
        errors: error.errors_for_response
      },
      status: error.http_status_code
    }
  end

  def initialize(model:)
    super()
    @model = model
  end

  def errors_for_response
    serialize_model_errors
  end

  private

  def serialize_model_errors
    model.errors.details.flat_map do |field, errors|
      errors.map do |error|
        {
          code: ErrorCodes.to_validation_error_code(error[:error]),
          message: normalize_message(field, error),
          field: field.to_s
        }
      end
    end
  end

  def normalize_message(field, error)
    error_type = error[:error]

    if error_type.is_a?(Symbol)
      options = error.except(:error)
      @model.errors.generate_message(field, error_type, options)
    else
      error_type
    end
  end
end
