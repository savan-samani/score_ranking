# frozen_string_literal: true

module Api
  class ScoresController < ApplicationController
    before_action :set_score, only: %i[show destroy]

    def index
      search = Scores::IndexQuery.new(search_params)

      if search.valid?
        scores = search.call

        render json: scores,
               include: search.include_in_serializer,
               meta: { total_count: search.total_count }
      else
        render ModelInvalidError.to_response(search)
      end
    end

    def show
      render json: @score, include: [:player]
    end

    def create
      service = ScoreCreator.new(create_params)
      score = service.call

      if score
        render json: score, include: [:player]
      else
        render ModelInvalidError.to_response(service)
      end
    end

    def destroy
      @score.destroy!

      head :ok
    end

    private

    def create_params
      params.require(:score).permit(:name, :score_point, :score_at)
    end

    def search_params
      params.permit(:name, :before_score_date, :after_score_date, :limit, :offset)
    end

    def set_score
      @score = Score.find(params[:id])
    end
  end
end
