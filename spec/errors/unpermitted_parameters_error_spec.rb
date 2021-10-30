# frozen_string_literal: true

require 'rails_helper'

describe UnpermittedParametersError do
  let(:error) { described_class.new }

  describe '#http_status_code' do
    it 'returns a 400 status' do
      expect(error.http_status_code).to eq(400)
    end
  end

  describe '#errors_for_response' do
    it 'returns an array of error' do
      expect(error.errors_for_response).to include({
                                                     message: /Contains incorrect parameter type/,
                                                     code: 400_000
                                                   })
    end
  end
end
