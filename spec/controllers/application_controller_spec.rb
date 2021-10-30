# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  subject(:index) { get :index }

  describe 'ActionController::ParameterMissing' do
    controller(described_class) do
      def index
        params = ActionController::Parameters.new(a: {})
        params.fetch(:b)
      end
    end

    it 'returns 400 status code' do
      index
      expect(response.status).to eq(400)
    end

    it 'returns errors as json' do
      index
      expect(
        JSON.parse(response.body).with_indifferent_access[:errors]
      ).to include({ message: I18n.t('errors.messages.parameter_missing_error'),
                     code: ErrorCodes::BASE_VALIDATION_ERROR_CLIENT })
    end
  end

  describe 'ActionController::UnpermittedParameters' do
    controller(described_class) do
      def index
        params = ActionController::Parameters.new(a: 'test')
        params.permit(:b)
      end
    end

    it 'returns 400 status code' do
      index
      expect(response.status).to eq(400)
    end

    it 'returns errors as json' do
      index
      expect(
        JSON.parse(response.body).with_indifferent_access[:errors]
      ).to include({ message: I18n.t('errors.messages.unpermitted_parameter_error'),
                     code: ErrorCodes::BASE_VALIDATION_ERROR_CLIENT })
    end
  end

  describe 'ActiveRecord::RecordNotFound' do
    controller(described_class) do
      def index
        raise ActiveRecord::RecordNotFound
      end
    end

    it 'returns 404 status code' do
      index
      expect(response.status).to eq(404)
    end

    it 'returns errors as json' do
      index
      expect(
        JSON.parse(response.body).with_indifferent_access[:errors]
      ).to include({ message: I18n.t('errors.messages.record_not_found'),
                     code: ErrorCodes::RECORD_NOT_FOUND })
    end
  end
end
