class AnswerController < ApplicationController
  def get_answer
    @answer = Alternative.find(params[:answer_id])
    respond_to do |format|
      format.json { render json: { is_correct: @answer.correct } }
    end
  end
end
