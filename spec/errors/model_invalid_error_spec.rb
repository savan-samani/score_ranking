# frozen_string_literal: true

describe ModelInvalidError do
  let(:score) { build(:score, score_point: 'a') }
  let(:error) { described_class.new(model: score) }

  before do
    score.valid?
  end

  describe '.to_response' do
    it 'returns a hash formatted to render as JSON' do
      expect(described_class.to_response(score)).to eq({ json: { errors: [{ code: 400_003,
                                                                            field: 'score_point',
                                                                            message: 'is not a number' }] },
                                                         status: 400 })
    end
  end

  describe '#http_status_code' do
    it 'returns a 400 status' do
      expect(error.http_status_code).to eq(400)
    end
  end

  describe '#errors_for_response' do
    it 'returns an array of model validation error' do
      expect(error.errors_for_response).to include({
                                                     code: 400_003,
                                                     field: 'score_point',
                                                     message: 'is not a number'
                                                   })
    end

    context 'when error message is a string' do
      it 'returns the error message as is' do
        score.errors.add(:base, 'random base error')
        expect(error.errors_for_response).to include({ code: 400_000, field: 'base', message: 'random base error' })
      end
    end
  end
end
