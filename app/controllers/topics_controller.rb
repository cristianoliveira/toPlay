class TopicsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :new_question, only: :show
  before_action :set_resume
  before_action :set_menu

  private
  def new_question
  	@question = Question.new
  end

  def set_resume
    @resume = Resume.find_by_topic_id(params[:id])
    @resume = Resume.new unless @resume
  end

  def set_menu
    @show_menu = true
  end
end
