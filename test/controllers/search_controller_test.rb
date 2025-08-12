require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  def setup
    @app3 = App.create!(name: "Prime Video 3")
    @movie = Movie.create!(title: "Interstellar", year: 2014, duration_in_seconds: 9000)
    @tv_show = TvShow.create!(title: "Stranger Things", year: 2016, duration_in_seconds: nil)
    @season = Season.create!(title: "Season 1", number: 1, year: 2016, tv_show: @tv_show)
    @episode = Episode.create!(title: "Chapter One", number: 1, season: @season, year: 2016, duration_in_seconds: 3600)
    @channel = Channel.create!(title: "Nickelodeon")
    @channel_program = ChannelProgram.create!(title: "SpongeBob", channel: @channel)
    # @movie.availabilities.create(app: @app3, country_code: 'ES')
  end

  test "should return results for valid query" do
    get "/search", params: { q: "interstellar" }
    assert_response :success
    body = JSON.parse(response.body)


    assert_includes body["movies"].map { |m| m["title"].downcase }, "interstellar"
  end

  test "should return results for year query" do
    get "/search", params: { q: "2016" }

    assert_response :success
    body = JSON.parse(response.body)

    assert_operator body["tv_shows"].size, :>=, 1
    assert_operator body["episodes"].size, :>=, 1
  end

  test "should return results for app name" do
    get "/search", params: { q: "Prime Video 3" }

    assert_response :success
    body = JSON.parse(response.body)

    assert_equal 1, body["apps"].size
    assert_equal "Prime Video 3", body["apps"].first["name"]
  end

  test "should return bad request if query is blank" do
    get "/search", params: { q: "" }

    assert_response :bad_request
    body = JSON.parse(response.body)

    assert_equal "Query cannot be blank", body["error"]
  end
end
