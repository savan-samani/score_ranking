# frozen_string_literal: true

class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :top_score, if: -> { @instance_options[:top_score].present? }
  attribute :low_score, if: -> { @instance_options[:low_score].present? }
  attribute :avg_score, if: -> { @instance_options[:avg_score].present? }

  has_many :scores

  def top_score
    @instance_options[:top_score].as_json(only: %i[score_point score_at])
  end

  def low_score
    @instance_options[:low_score].as_json(only: %i[score_point score_at])
  end

  def avg_score
    @instance_options[:avg_score]
  end
end
