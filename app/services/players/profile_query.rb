# frozen_string_literal: true

module Players
  class ProfileQuery
    include ActiveModel::Model

    attr_accessor :id # Int

    validates :id, presence: true, numericality: { greater_than: 0 }

    def call
      @call ||= Player.includes(:scores).order('scores.score_point DESC').find(id)
    end

    def top_score
      call.scores.first
    end

    def low_score
      call.scores.last
    end

    def avg_score
      call.scores.average(:score_point).to_f
    end
  end
end
