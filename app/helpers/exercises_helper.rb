module ExercisesHelper

  def correct(exercise, index)
    begin
      alternative = exercise.alternatives[index]
      return "correct" if alternative.correct?
    rescue
      return nil
    end
  end

end
