# frozen_string_literal: true

require 'rails_helper'

describe Players::ProfileQuery do
  let(:params) { { id: player.id } }
  let(:service) { described_class.new(params) }
  let(:player) { create(:player) }

  before do
    4.times do |n|
      create(:score, player: player, score_point: n + 1, score_at: DateTime.now + 1.day)
    end
  end

  context 'with validations' do
    it 'check presence of id' do
      service.id = nil
      service.valid?
      expect(service.errors[:id]).to include(/can't be blank/)
    end

    it 'check id is greater than 0' do
      service.id = 0
      service.valid?
      expect(service.errors[:id]).to include('must be greater than 0')
    end
  end

  describe '#call' do
    it 'returns a player record' do
      response = service.call
      expect(response).to be_a(Player)
      expect(response).to eq(player)
    end

    context 'when player does not exist' do
      it 'raises ActiveRecord::RecordNotFound' do
        service.id = player.id + 1_000_000
        expect { service.call }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#*_score' do
    let(:scores) { player.scores.reverse }

    context 'with top_score' do
      it 'returns score record with maximum score_point' do
        response = service.top_score
        expect(response).to be_a(Score)
        expect(response).to eq(scores.first)
      end
    end

    context 'with low_score' do
      it 'returns score record with minimum score_point' do
        response = service.low_score
        expect(response).to be_a(Score)
        expect(response).to eq(scores.last)
      end
    end

    context 'with avg_score' do
      let(:score_points) { scores.map(&:score_point) }

      it 'returns float value as average score of player' do
        response = service.avg_score
        expect(response).to be_a(Float)
        expect(response).to eq(score_points.sum(0.0) / score_points.size)
      end
    end
  end
end
