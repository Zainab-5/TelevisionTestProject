class FavoriteAppsController < ApplicationController
  before_action :set_user
  before_action :set_app
  skip_before_action :verify_authenticity_token

  def index
    user = User.find(params[:user_id])

    apps = App.joins(:favorite_apps)
            .where(favorite_apps: { user_id: user.id })
            .order("favorite_apps.position ASC")
            .page(params[:page])
            .per(params[:per_page] || 10)

    render json: {
      current_page: apps.current_page,
      total_pages: apps.total_pages,
      total_count: apps.total_count,
      apps: apps
    }
  end

  def create
    favorite = FavoriteApp.find_or_initialize_by(user: @user, app: @app)


    if favorite.update(position: params[:position])
      render json: { success: true, favorite_app: favorite }, status: :ok
    else
      render json: { success: false, errors: favorite.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def set_app
    @app = App.find_by(id: params[:app_id])
  end
end
