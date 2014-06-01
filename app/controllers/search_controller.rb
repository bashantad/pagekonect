class SearchController < ApplicationController

  def index
    if query = params[:query] && (search_index = PgSearch.multisearch(params[:query])).present?
      @search_results = search_index.map(&:searchable).sort{|a,b| b.created_at <=> a.created_at}
      @title_length = 83
      @iframe_width = 230
      @iframe_height = 150
    end
  end
end
