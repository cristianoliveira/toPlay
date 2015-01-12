class QuestionsController < InheritedResources::Base

  respond_to :json, :only => :create

  def create
    create! do |format|
      format.js
    end
  end

  def upvote
    @question = Question.find(params[:id])

    if current_user.voted_up_on? @question
      @question.unliked_by current_user
    else
      @question.liked_by current_user
    end


    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @question.get_upvotes.size.to_s.rjust(3, '0') } }
    end

  end

  def downvote
    @question = Question.find(params[:id])

    if current_user.voted_down_on? @question
      @question.undisliked_by current_user
    else
      @question.disliked_by current_user
    end

    respond_to do |format|
      format.html {redirect_to :back }
      format.json { render json: { count: @question.get_downvotes.size.to_s.rjust(3, '0') } }
    end
  end


  private

    def permitted_params
      params.permit(:question => [:user_id, :topic_id, :description, :parent_id])
    end
end
