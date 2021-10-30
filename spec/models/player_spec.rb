# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player) { build(:player) }

  context 'with validations' do
    it 'check the presence of player name' do
      player.name = nil
      player.valid?
      expect(player.errors[:name]).to include(/can't be blank/)
    end

    it 'check the uniqueness of player name' do
      player.save!
      new_player = build(:player, name: player.name)
      new_player.valid?
      expect(new_player.errors[:name]).to include(/has already been taken/)
    end
  end
end
