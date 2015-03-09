class UserExerciseAnswersController < InheritedResources::Base

  def create
    create! do |format|
      respond(format, @user_exercise_answer)
    end
  end

  def update
    update! do |format|
      respond(format, @user_exercise_answer)
    end
  end

  private
  def respond(format ,answer)
    if answer.errors.any?
      format.json { render json: { "error" => answer.errors.messages } , status: 422 }
    else
      format.json { render json: { "result" => { "is_correct_answer" => answer.correct? } } }
    end
  end

  def permitted_params
    params.permit(:user_exercise_answer => [:user_id, :exercise_id, :alternative_id])
  end
end
