class ChannelsController < ApplicationController
  def show
    channel = Channel.includes(channel_programs: :availabilities)
                     .find_by(id: params[:id])

    if channel
      render json: channel.as_json(include: {
        channel_programs: {
          include: :availabilities
        },
        availabilities: {}
      })
    else
      render json: { error: "Channel not found" }, status: :not_found
    end
  end
end
