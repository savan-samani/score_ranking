# frozen_string_literal: true

class ScoreCreator
  include ActiveModel::Model

  attr_accessor :name, :score_point, :score_at

  validates :name, presence: true
  validates :score_point, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :score_at, presence: true, iso8601: true

  def call
    valid? && persist!
  end

  private

  def persist!
    player.scores.create!(score_point: score_point, score_at: score_at)
  end

  def player
    @player ||= Player.find_by(name: name) || Player.create(name: name)
  end
end
