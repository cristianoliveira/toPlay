class SearchController < ApplicationController

  LIKE_CONDITION = "upper(%s) LIKE ?"

  def index
    @query = params[:q].upcase!

    @topics_results = []
    @topics_results << @courses = Course.where(LIKE_CONDITION % :name, "%#{@query}%")
    @topics_results << Topic.where(LIKE_CONDITION % :name, "%#{@query}%")

    @videos = Video.where(LIKE_CONDITION % "title||description", "%#{@query}%")
  end
end
