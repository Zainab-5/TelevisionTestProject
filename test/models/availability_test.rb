require "test_helper"

class AvailabilityTest < ActiveSupport::TestCase
  def setup
    @app = App.create!(name: "789")
    @movie = Movie.create!(title: "Inception", year: 2010, duration_in_seconds: 8880)
    @availability = Availability.new(app: @app, available_for: @movie, country_code: "US")
  end

  test "should be valid with valid attributes" do
    assert @availability.valid?
  end

  test "should be invalid without an app" do
    @availability.app = nil
    assert_not @availability.valid?
    assert_includes @availability.errors[:app], "must exist"
  end

  test "should be invalid without available_for polymorphic association" do
    @availability.available_for = nil
    assert_not @availability.valid?
    assert_includes @availability.errors[:available_for], "must exist"
  end

  test "should belong to app" do
    assert_equal @app, @availability.app
  end

  test "should belong to available_for polymorphic" do
    assert_equal @movie, @availability.available_for
  end

  test "should not allow duplicate availability per app, content, and country" do
    @availability.save!
    duplicate = Availability.new(
      app: @availability.app,
      available_for: @availability.available_for,
      country_code: @availability.country_code
    )
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:app_id], "can only have one availability per content per country"
  end
end
