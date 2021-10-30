# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    sequence(:name) { |n| "player_name#{n}" }
  end
end
