require "test_helper"

class FavoriteAppTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: "user@example.com")
    @app = App.create!(name: "Netflix2")
  end

  test "should be valid with valid attributes" do
    favorite = FavoriteApp.new(user: @user, app: @app, position: 1)
    assert favorite.valid?
  end

  test "should be invalid without user" do
    favorite = FavoriteApp.new(app: @app, position: 1)
    assert_not favorite.valid?
    assert_includes favorite.errors[:user], "must exist"
  end

  test "should be invalid without app" do
    favorite = FavoriteApp.new(user: @user, position: 1)
    assert_not favorite.valid?
    assert_includes favorite.errors[:app], "must exist"
  end

  test "should allow nil position" do
    favorite = FavoriteApp.new(user: @user, app: @app, position: nil)
    assert favorite.valid?
  end

  test "should not allow non-integer position" do
    favorite = FavoriteApp.new(user: @user, app: @app, position: "first")
    assert_not favorite.valid?
    assert_includes favorite.errors[:position], "is not a number"
  end

  test "should not allow position less than 1" do
    favorite = FavoriteApp.new(user: @user, app: @app, position: 0)
    assert_not favorite.valid?
    assert_includes favorite.errors[:position], "must be greater than 0"
  end

  test "should not allow duplicate favorite for the same user and app" do
    FavoriteApp.create!(user: @user, app: @app, position: 1)
    duplicate = FavoriteApp.new(user: @user, app: @app, position: 2)

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:app_id], "has already been favorited by this user"
  end
end
