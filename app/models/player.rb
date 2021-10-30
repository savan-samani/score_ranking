# frozen_string_literal: true

class Player < ApplicationRecord
  has_many :scores, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
