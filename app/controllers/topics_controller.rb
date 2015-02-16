class TopicsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :new_question, only: :show

  private
  def new_question
  	@question = Question.new
  end
end
