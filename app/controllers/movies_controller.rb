class MoviesController < ApplicationController
  def show
    movie = Movie.find_by(id: params[:id])

    render json: movie
  end
end
