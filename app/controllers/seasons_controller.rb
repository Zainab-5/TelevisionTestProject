class SeasonsController < ApplicationController
  def show
    season = Season.includes(episodes: :availabilities).find_by(id: params[:id])

    render json: season.as_json(include: {
        episodes: {
            include: :availabilities
        },
        availabilities: {}
    })
  end
end
