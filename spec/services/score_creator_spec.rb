# frozen_string_literal: true

describe ScoreCreator do
  let(:form_params) do
    {
      name: 'test',
      score_point: 10,
      score_at: '2021-05-19T12:00:00+09:00'
    }
  end

  let(:creator) { described_class.new(form_params) }

  context 'with validations' do
    it 'check the presence of player name' do
      creator.name = nil
      creator.valid?
      expect(creator.errors[:name]).to include(/can't be blank/)
    end

    it 'check presence of score_point' do
      creator.score_point = nil
      creator.valid?
      expect(creator.errors[:score_point]).to include(/can't be blank/)
    end

    it 'check score_point is integer' do
      creator.score_point = 'a'
      creator.valid?
      expect(creator.errors[:score_point]).to include(/is not a number/)
    end

    it 'check score_point is greater than or equal to zero' do
      creator.score_point = -1
      creator.valid?
      expect(creator.errors[:score_point]).to include(/must be greater than or equal to 0/)
    end

    it 'check presence of score_at' do
      creator.score_at = nil
      creator.valid?
      expect(creator.errors[:score_at]).to include(/can't be blank/)
    end

    it 'checks the iso8601 format of score_at' do
      creator.score_at = '2021-05-019T12:00'
      creator.valid?
      expect(creator.errors[:score_at]).to include(/is invalid/)
    end
  end

  describe '#call' do
    it 'creates a player record' do
      expect do
        creator.call
      end.to change(Player, :count).by(1)
    end

    it 'returns a player record is exist' do
      creator.call
      expect(Player.count).to eq(1)
    end

    it 'creates an score record' do
      expect do
        creator.call
      end.to change(Score, :count).by(1)
    end

    it 'returns an score record' do
      expect(creator.call).to be_a(Score)
    end
  end
end
