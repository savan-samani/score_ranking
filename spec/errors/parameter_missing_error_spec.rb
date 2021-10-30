# frozen_string_literal: true

require 'rails_helper'

describe ParameterMissingError do
  let(:error) { described_class.new }

  describe '#http_status_code' do
    it 'retuns a 400 status' do
      expect(error.http_status_code).to eq(400)
    end
  end

  describe '#erros_for_response' do
    it 'returns an array pf error' do
      expect(error.errors_for_response).to include({
                                                     message: /The required parameters are not included/,
                                                     code: 400_000
                                                   })
    end
  end
end
