class ChannelProgramsController < ApplicationController
  def show
    program = ChannelProgram.includes(:schedules).find_by(id: params[:id])

    unless program
        return render json: { error: "Program not found" }, status: :not_found
    end

    time_watched = current_user&.time_watched_records
                                &.find_by(channel_program: program)&.seconds_watched || 0

    render json: program.as_json(include: {
        schedules: {},
        availabilities: {}
    }).merge(time_watched_seconds: time_watched)
    end

  private

  def current_user
    @current ||= User.find_by(id: params[:user_id])
  end
end
