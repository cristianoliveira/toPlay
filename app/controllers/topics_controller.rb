class TopicsController < InheritedResources::Base

  respond_to :html, :json

  before_action :authenticate_user!
  before_action :set_up
  before_action :set_resume
  before_action :set_menu

  @@topic
  @question

  private
  def set_up
    @@topic = Topic.find(topic_params)
  	@question = Question.new
  end

  def set_resume
    @resume = Resume.find_by_topic_id(@@topic.id)
    @resume = Resume.new unless @resume
  end

  def set_menu
    @show_menu = true
  end

  def topic_params
      return params.require(:id) if params[:id]
      params.require(:level_id)
  end
end
