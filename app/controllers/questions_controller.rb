class QuestionsController < InheritedResources::Base
  before_action :authenticate_user!
  before_action :find_question, only: [:show, :edit, :destroy]

  respond_to :json, :only => [ :create, :edit ]

  def show
    render layout: false
  end

  def create
    create! do |format|
      if @question.errors.any?
        format.json { render json: { "error" => @question.errors.messages } , status: 422 }
        format.html {
          flash[:message] = @question.errors.full_messages
          render partial: 'questions/question', locals: { question: @question }
        }
      else
        format.json { render json: { :result => @question } }
        format.html { render partial: 'questions/question', locals: { question: @question } }
      end
    end
  end

  def destroy

    if @question
      unless @question.delete
        flash[:message] = @question.errors.full_messages
      end
    else
      flash[:message] = 'Conteúdo não foi encontrado'
    end

    redirect_to :back
  end

  def upvote
    @current_user = current_user
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
    @current_user = current_user
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

    def find_question
      @question = Question.find(params[:id])
    end
end
