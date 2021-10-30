# frozen_string_literal: true

module Scores
  class IndexQuery
    include Searchable

    search_from model: Score, serializer: ScoreSerializer

    attr_accessor :before_score_date, # Date
                  :after_score_date, # Date
                  :name, # String,
                  :limit, # Int
                  :offset # Int

    validates :before_score_date, date_format: true, if: -> { before_score_date.present? }
    validates :after_score_date, date_format: true, if: -> { after_score_date.present? }
    validates :limit, numericality: { greater_than: 0 }
    validates :offset, numericality: { greater_than_or_equal_to: 0 }

    def call
      perform_search do |_score|
        filter_by('players.name', name, csv: true)
        filter_by(:score_at, score_at)
      end
    end

    def includes
      'player'
    end

    private

    # Filter
    def filter_by(attr, value, csv: false)
      return @query if value.blank?

      value = value.to_s.split(',') if csv
      @query = query.where(attr => value)
    end

    def score_at
      if before_score_date.present? && after_score_date.present?
        [after_score_date.to_datetime..before_score_date.to_datetime]
      elsif before_score_date.present?
        [..before_score_date.to_datetime]
      elsif after_score_date.present?
        [after_score_date.to_datetime..]
      end
    end
  end
end
