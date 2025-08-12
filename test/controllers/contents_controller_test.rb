require "test_helper"

class ContentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @country_code = "US"

    @movie = Movie.create!(title: "Test Movie", year: 2022)
    @tv_show = TvShow.create!(title: "Test Show", year: 2021)

    @availability_movie = Availability.create!(
      app: App.create!(name: "App 1"),
      available_for: @movie,
      country_code: @country_code
    )

    @availability_tv_show = Availability.create!(
      app: App.create!(name: "App 2"),
      available_for: @tv_show,
      country_code: @country_code
    )
  end

  test "should return all contents with type when no type param" do
    get contents_path, params: { country_code: @country_code }, as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    types = json_response.map { |item| item["type"] }

    assert_includes types, "Movie"
    assert_includes types, "TvShow"
  end

  test "should filter by type param" do
    get contents_path, params: { country_code: @country_code, type: "Movie" }, as: :json

    assert_response :success
    json_response = JSON.parse(response.body)

    assert json_response.all? { |item| item["type"] == "Movie" }
  end

  test "should return empty array if no contents for given country" do
    get contents_url, params: { country_code: "XX" }, as: :json

    assert_response :success
    json_response = JSON.parse(response.body)
    assert_equal [], json_response
  end
end
