require "test_helper"

class FavoriteAppsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(email: "user@example.com")
    @app1 = App.create!(name: "Rakuteen")
    @app2 = App.create!(name: "Prime Video 2")

    @favorite = FavoriteApp.create!(user: @user, app: @app1, position: 1)
  end

  test "should list favorite apps for a user ordered by position" do
    FavoriteApp.create!(user: @user, app: @app2, position: 2)

    get user_favorite_apps_path(@user)

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal "Rakuteen", body["apps"].first["name"]
    assert_equal "Prime Video 2", body["apps"].last["name"]
  end

  test "should favorite an app and set position" do
    post user_favorite_apps_path(@user), params: {
      app_id: @app2.id,
      position: 3
    }

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal true, body["success"]
    assert_equal 3, body["favorite_app"]["position"]
    assert_equal @user.id, body["favorite_app"]["user_id"]
    assert_equal @app2.id, body["favorite_app"]["app_id"]
  end

  test "should update existing favorite app's position" do
    post user_favorite_apps_path(@user), params: {
      app_id: @app1.id,
      position: 5
    }

    assert_response :success
    body = JSON.parse(response.body)
    assert_equal true, body["success"]
    assert_equal 5, body["favorite_app"]["position"]
  end

  test "should return error for invalid position" do
    post user_favorite_apps_path(@user), params: {
      app_id: @app2.id,
      position: -1
    }

    assert_response :unprocessable_entity
    body = JSON.parse(response.body)
    assert_equal false, body["success"]
    assert_includes body["errors"], "Position must be greater than 0"
  end
end
