# frozen_string_literal: true

module Api
  class PlayersController < ApplicationController
    def show
      service = Players::ProfileQuery.new(id: params[:id])
      if service.valid?
        player = service.call

        render json: player, top_score: service.top_score, low_score: service.low_score, avg_score: service.avg_score
      else
        render ModelInvalidError.to_response(service)
      end
    end
  end
end
