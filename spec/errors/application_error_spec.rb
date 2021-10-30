# frozen_string_literal: true

require 'rails_helper'

describe ApplicationError do
  let!(:error) { described_class.new }

  context 'with #http_status_code' do
    it 'return the default 500 error' do
      expect(error.http_status_code).to eq(500)
    end
  end

  describe '#errors_for_response' do
    it 'raises a NotImplementedError' do
      expect do
        error.errors_for_response
      end.to raise_error(NotImplementedError, /You must implement/)
    end
  end

  describe '#error_logs' do
    it 'build the logs from exception' do
      exception = StandardError.new('test')
      exception.set_backtrace([])

      expect(error.error_logs(exception)).to eq('ApplicationError: StandardError: "test": ')
    end
  end
end
