class EpisodesController < ApplicationController
  def show
    episode = Episode.find_by(id: params[:id])
    return render json: { error: "Episode not found" }, status: :not_found unless episode

    render json: episode
  end
end
