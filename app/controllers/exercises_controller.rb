class ExercisesController < InheritedResources::Base

  before_action :find_exercise, only: [:show, :delete]

  def show
    render layout: false
  end

  def delete
    if @exercise.delete
      flash[:message] = "Exercício deletado com sucesso."
    else
      flash[:message] = @exercise.errors.full_messages
    end
    redirect_to :back
  end

  private
  def find_exercise
    @exercise = Exercise.find(params[:id])
  end
end
