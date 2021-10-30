# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :player

  validates :score_point, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :score_at, presence: true
end
