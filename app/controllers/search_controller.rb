class SearchController < ApplicationController
  CONTENT_TYPES = %w[Movie TvShow Season Episode Channel ChannelProgram].freeze

  def search
    query = params[:q].to_s.strip.downcase
    return render json: { error: "Query cannot be blank" }, status: :bad_request if query.blank?

    results = {}

    CONTENT_TYPES.each do |type|
      model = type.constantize
      results[type.underscore.pluralize.to_sym] = search_model(model, query)
    end

    results[:apps] = search_apps(query)

    render json: results
  end

  private

  # A search that returns all possible types of content based on the query. The search can
  # be done through the title or the year. In the case of an App through its name.

  def search_model(model, query)
    if model.column_names.include?("year")
      model.where("LOWER(title) LIKE ? OR CAST(year AS TEXT) LIKE ?", "%#{query}%", "%#{query}%")
    else
      model.where("LOWER(title) LIKE ?", "%#{query}%")
    end
  end

  def search_apps(query)
    App.where("LOWER(name) LIKE ?", "%#{query}%")
  end
end
