class AnswerController < ApplicationController
  def get_answer
    @exercise = Exercise.find(params[:exercise_id])
    @correct_answer = Alternative.where(correct: true).first

    respond_to do |format|
      format.json { render json: { is_correct: @correct_answer.id == params[:answer_id] } }
    end
  end
end
