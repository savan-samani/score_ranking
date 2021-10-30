# frozen_string_literal: true

FactoryBot.define do
  factory :score do
    player
    score_point { 10 }
    score_at { DateTime.now }
  end
end
