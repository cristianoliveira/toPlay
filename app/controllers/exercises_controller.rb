class ExercisesController < InheritedResources::Base

  before_action :find_exercise, only: [:show, :delete, :update]

  def show
    render layout: false
  end

  def update
    p "UPDATING"
    if @exercise.update(exercise_permited_params)
      @exercise.alternatives.each_with_index do |a,i|
        a.description = params["alternatives"]["#{i}"]
        a.correct = params[:alternatives][:correct] == i.to_s
        a.save
      end
    end

    respond_to do |format|
      format.html { redirect_to topic_path(@exercise.topic_id) }
      format.json {
        render json: {
          result: 'ok',
          redirect_to: topic_path(@exercise.topic_id)
        }
      }
    end
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

  def exercise_permited_params
    params.require(:exercise).permit(:id, :topic_id, :description)
  end
end
