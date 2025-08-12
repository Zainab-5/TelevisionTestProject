require "json"

namespace :import do
  desc "Import content from JSON"
  task streams: :environment do
    file_path = Rails.root.join("db/data/streams_data.json")
    json = JSON.parse(File.read(file_path))

    puts "Starting import..."

    import_movies(json["movies"])
    import_tv_shows(json["tv_shows"])
    import_channels(json["channels"])

    puts "✅ Import complete."
  end

  def import_movies(movies)
    movies.each do |movie_data|
      movie = Movie.find_or_create_by!(
        title: movie_data["original_title"],
        year: movie_data["year"],
        duration_in_seconds: movie_data["duration_in_seconds"]
      )

      movie_data["availabilities"].each do |availability|
        app = App.find_or_create_by!(name: availability["app"])
        movie.availabilities.find_or_create_by!(
          app: app,
          country_code: availability["market"]
        )
      end
    end
  end

  def import_tv_shows(tv_shows)
    tv_shows.each do |tv_data|
      tv_show = TvShow.find_or_create_by!(
        title: tv_data["original_title"],
        year: tv_data["year"]
      )

      # availabilities for whole TV show
      tv_data["availabilities"].each do |availability|
        app = App.find_or_create_by!(name: availability["app"])
        tv_show.availabilities.find_or_create_by!(
          app: app,
          country_code: availability["market"]
        )
      end

      # seasons
      tv_data["seasons"].each do |season_data|
        season = tv_show.seasons.find_or_create_by!(
          number: season_data["number"],
          title: season_data["original_title"],
          year: season_data["year"]
        )

        season_data["availabilities"].each do |availability|
          app = App.find_or_create_by!(name: availability["app"])
          season.availabilities.find_or_create_by!(
            app: app,
            country_code: availability["market"]
          )
        end
      end

      # episodes
      tv_data["episodes"].each do |episode_data|
        season = tv_show.seasons.find_by(number: episode_data["season_number"])

        next unless season

        episode = season.episodes.find_or_create_by!(
          number: episode_data["number"],
          title: episode_data["original_title"],
          year: episode_data["year"],
          duration_in_seconds: episode_data["duration_in_seconds"]
        )
      end
    end
  end

  def import_channels(channels)
    channels.each do |channel_data|
      channel = Channel.find_or_create_by!(title: channel_data["original_title"])

      channel_data["availabilities"].each do |availability|
        app = App.find_or_create_by!(name: availability["app"])
        channel.availabilities.find_or_create_by!(
          app: app,
          country_code: availability["market"]
        )
      end

      channel_data["channel_programs"].each do |program_data|
        program = channel.channel_programs.find_or_create_by!(
          title: program_data["original_title"]
        )

        program_data["availabilities"].each do |availability|
          app = App.find_or_create_by!(name: availability["app"])
          program.availabilities.find_or_create_by!(
            app: app,
            country_code: availability["market"]
          )
        end

        program_data["schedule"].each do |schedule|
          program.schedules.find_or_create_by!(
            start_time: schedule["start_time"],
            end_time: schedule["end_time"]
          )
        end
      end
    end
  end
end
