class SearchController < ApplicationController
  skip_authorization_check
  
  def index
    if params[:q]
      @results = Elasticsearch::Model.search(params[:q], [Item, Character])
      render 'search'
    end
  end
end
