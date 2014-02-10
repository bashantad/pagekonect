class SearchController < ApplicationController

  def index
    if query = params[:query] && (search_index = PgSearch.multisearch(params[:query])).present?
      @search_results = search_index.map(&:searchable)
    else
      render text: "Try different query paramters."
    end
  end
end
