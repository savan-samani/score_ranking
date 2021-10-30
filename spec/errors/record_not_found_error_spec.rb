# frozen_string_literal: true

require 'rails_helper'

describe RecordNotFoundError do
  let(:error) { described_class.new }

  describe '#http_status_code' do
    it 'returns a 404 status' do
      expect(error.http_status_code).to eq(404)
    end
  end

  describe '#errors_for_response' do
    it 'returns a array os error' do
      expect(error.errors_for_response).to include({
                                                     message: /The target item does not exist/,
                                                     code: 404_002
                                                   })
    end
  end
end
