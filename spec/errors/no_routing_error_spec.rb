# frozen_string_literal: true

require 'rails_helper'

describe NoRoutingError do
  let(:error) { described_class.new(path: 'random_path') }

  describe '#http_status_code' do
    it 'returns a 404 status' do
      expect(error.http_status_code).to eq(404)
    end
  end

  describe '#errors_for_response' do
    it 'returns an array of error' do
      expect(error.errors_for_response).to include({
                                                     message: /No routing: random_path/,
                                                     code: 404_001
                                                   })
    end
  end
end
