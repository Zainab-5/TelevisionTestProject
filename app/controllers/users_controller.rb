class UsersController < ApplicationController
  before_action :set_user

  def favorite_channel_programs
    render json: @user.favorite_channel_programs_with_time
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end
end
