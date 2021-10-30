# frozen_string_literal: true

class ScoreSerializer < ActiveModel::Serializer
  ATTRS = %i[
    id
    score_point
    score_at
    created_at
    updated_at
  ].freeze

  ATTRS.each do |attr|
    attribute attr, if: -> { object.respond_to?(attr) }
  end

  has_one :player
end
