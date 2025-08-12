class User < ApplicationRecord
  has_many :favorite_apps, dependent: :destroy
  has_many :apps, through: :favorite_apps


  has_many :time_watched_records, class_name: "TimeWatched", dependent: :destroy
  has_many :watched_channel_programs, through: :time_watched_records, source: :channel_program

  def favorite_channel_programs_with_time
    time_watched_records
        .includes(:channel_program)
        .order(seconds_watched: :desc)
        .map do |record|
            {
                program: record.channel_program,
                seconds_watched: record.seconds_watched
            }
        end
    end

  def ordered_favorite_apps_relation(desc: false)
    apps.joins(:favorite_apps).where(favorite_apps: { user_id: id }).order("favorite_apps.position #{desc ? 'DESC' : 'ASC'}")
  end
end
