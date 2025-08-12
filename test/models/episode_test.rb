require "test_helper"

class EpisodeTest < ActiveSupport::TestCase
  def setup
    @app = App.create!(name: "123")

    @tv_show = TvShow.create!(title: "Test Show")

    @season = Season.create!(
      title: "Season 1",
      number: 1,
      year: 2023,
      tv_show: @tv_show
    )

    @season.availabilities.create(app: @app, country_code: "ES")

    @episode = Episode.new(
      title: "Episode 1",
      number: 1,
      year: 2023,
      duration_in_seconds: 1800,
      season: @season
    )
  end

  test "should be valid with valid attributes" do
    assert @episode.valid?
  end

  test "should require a number" do
    @episode.number = nil
    assert_not @episode.valid?
    assert_includes @episode.errors[:number], "can't be blank"
  end

  test "should enforce unique number within the same season" do
    @episode.save!
    duplicate = @episode.dup
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:number], "must be unique within the same season"
  end

  test "should allow same number in different seasons" do
    @episode.save!
    another_season = Season.create!(
      title: "Season 2",
      number: 2,
      year: 2024,
      tv_show: @tv_show
    )

    same_number_episode = Episode.new(
      title: "Episode 1 in Season 2",
      number: 1,
      year: 2024,
      duration_in_seconds: 1800,
      season: another_season
    )

    assert same_number_episode.valid?
  end
end
