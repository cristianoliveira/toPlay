class ExercisesController < InheritedResources::Base

  before_action :find_exercise, only: [:show, :delete, :update]

  def show
    render layout: false
  end

  def update
    if @exercise.update(exercise_permited_params)
      @exercise.alternatives.map{|a|
        a.delete
        a.save
      }

      params["alternatives"].each_with_index do |value,i|
        unless value[1].empty?
          alternative = @exercise.alternatives.new
          alternative.description = value[1]
          alternative.correct = params["alternatives-correct"] == value[0]
          alternative.save
        end
      end

    end

    respond_to do |format|
      format.html {
        flash[:message] = "Exercício atualizado com sucesso."
        redirect_to topic_path(@exercise.topic_id)
      }
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
    params.require(:exercise).permit(:id, :topic_id, :description, :cover)
  end
end
