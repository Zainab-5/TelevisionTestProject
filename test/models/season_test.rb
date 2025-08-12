require "test_helper"

class SeasonTest < ActiveSupport::TestCase
  def setup
    @app = App.create!(name: "124")
    @tv_show = TvShow.create!(title: "Sample Show")
    @season = Season.new(tv_show: @tv_show)
  end

  test "should be valid with valid attributes" do
    assert @season.valid?
  end

  test "should belong to a tv_show" do
    @season.tv_show = nil
    assert_not @season.valid?
  end

  test "should have many episodes" do
    @season.save!
    episode1 = @season.episodes.create!(number: 1)
    episode2 = @season.episodes.create!(number: 2)
    assert_equal 2, @season.episodes.count
    assert_includes @season.episodes, episode1
    assert_includes @season.episodes, episode2
  end

  test "should have many availabilities" do
    @season.save!
    availability1 = @season.availabilities.create!(country_code: "US", app: @app)
    availability2 = @season.availabilities.create!(country_code: "UK", app: @app)
    assert_equal 2, @season.availabilities.count
    assert_includes @season.availabilities, availability1
    assert_includes @season.availabilities, availability2
  end
end
