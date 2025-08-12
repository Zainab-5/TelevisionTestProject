class TvShowsController < ApplicationController
  def show
    tv_show = TvShow.includes(seasons: :availabilities)
                    .find_by(id: params[:id])

    if tv_show
      episodes_with_season_number = tv_show.episodes.map do |episode|
        episode.as_json.merge(
          "season_number" => episode.season.number
        ).except("season_id")
      end

      render json: tv_show.as_json(include: {
        seasons: {
          include: :availabilities
        },
        availabilities: {}
      }).merge(episodes: episodes_with_season_number)
    else
      render json: { error: "TV Show not found" }, status: :not_found
    end
  end
end
