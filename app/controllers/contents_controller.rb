class ContentsController < ApplicationController
  ALLOWED_TYPES = {
    "movie" => Movie,
    "tv_show" => TvShow,
    "season" => Season,
    "episode" => Episode,
    "channel" => Channel,
    "channel_program" => ChannelProgram
  }.freeze


  def index
    type = params[:type].to_s.underscore
    model = ALLOWED_TYPES[type]

    if model
      records = model.joins(:availabilities).where(availabilities: { country_code: params[:country_code] })
    else
      records = Availability.includes(:available_for).where(country_code: params[:country_code]).map(&:available_for).uniq
    end

    results = records.map do |record|
      record.as_json.merge(type: record.class.name)
    end

    render json: results
  end
end
