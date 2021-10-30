# frozen_string_literal: true

require 'rails_helper'

describe Scores::IndexQuery do
  let(:params) { {} }
  let(:search) { described_class.new(params) }
  let!(:score) { create(:score) }

  before do
    3.times do |n|
      day = score.score_at + (n + 1).day
      create(:score, score_at: day)
    end
  end

  context 'with validations' do
    it 'check the format of before_score_date when present' do
      search.before_score_date = '2021/05/19'
      search.valid?

      expect(search.errors[:before_score_date]).to include(/is invalid/)
    end

    it 'check the format of after_score_date when present' do
      search.after_score_date = '2021/05/19'
      search.valid?

      expect(search.errors[:after_score_date]).to include(/is invalid/)
    end

    it 'check numericality of limit' do
      search.valid?

      expect(search.errors[:limit]).to include(/is not a number/)
    end

    it 'check limit is greater than 0' do
      search.limit = 0
      search.valid?

      expect(search.errors[:limit]).to include(/must be greater than 0/)
    end

    it 'check numericality of offset' do
      search.valid?

      expect(search.errors[:offset]).to include(/is not a number/)
    end

    it 'check offset is greater than or equal to 0' do
      search.offset = -1
      search.valid?

      expect(search.errors[:offset]).to include(/must be greater than or equal to 0/)
    end
  end

  describe '#call' do
    let(:params) { { limit: 10, offset: 0 } }

    before do
      search.includes = 'player'
    end

    it 'returns a list of scores when no params' do
      expect(search.call).to include(score)
    end

    it 'with limit' do
      search.limit = 2
      expect(search.call.count).to eq(2)
    end

    it 'with offset' do
      search.limit = 10
      search.offset = 3
      expect(search.call).not_to include(score)
      expect(search.call.count).to eq(1)
    end

    context 'with filters' do
      it 'check by correct name' do
        search.name = score.player.name
        expect(search.call).to include(score)
      end

      it 'check by incorrect name' do
        search.name = 'name_not_exist'
        expect(search.call).to be_blank
      end
    end

    context 'with score_at filter' do
      it 'by before_score_date' do
        search.before_score_date = score.score_at + 1.day
        expect(search.call).to include(score)
        expect(search.call.count).to eq(2)
      end

      it 'by after_score_date' do
        search.after_score_date = score.score_at - 1.day
        expect(search.call).to include(score)
        expect(search.call.count).to eq(4)
      end

      it 'by before_score_date & after_score_date' do
        search.after_score_date = score.score_at + 1.day
        search.before_score_date = score.score_at + 5.days
        expect(search.call.count).to eq(3)
      end
    end

    describe '#total_count' do
      let(:params) { { limit: 2, offset: 0 } }

      it 'returns the total number of records ignoring the limit' do
        search.call
        expect(search.total_count).to eq(4)
      end
    end

    describe '#include_in_serializer' do
      it 'returns an array' do
        expect(search.include_in_serializer).to eq(%w[player])
      end
    end
  end
end
