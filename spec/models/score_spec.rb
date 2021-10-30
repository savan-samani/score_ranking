# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Score, type: :model do
  let!(:score) { create(:score) }

  context 'with validations' do
    it 'check presence of player record' do
      score.player = nil
      score.valid?
      expect(score.errors[:player]).to include(/must exist/)
    end

    it 'check presence of score_point' do
      score.score_point = nil
      score.valid?
      expect(score.errors[:score_point]).to include(/can't be blank/)
    end

    it 'check score_point is integer' do
      score.score_point = 'a'
      score.valid?
      expect(score.errors[:score_point]).to include(/is not a number/)
    end

    it 'check score_point is greater than or equal to zero' do
      score.score_point = -1
      score.valid?
      expect(score.errors[:score_point]).to include(/must be greater than or equal to 0/)
    end

    it 'check presence of score_at' do
      score.score_at = nil
      score.valid?
      expect(score.errors[:score_at]).to include(/can't be blank/)
    end
  end
end
