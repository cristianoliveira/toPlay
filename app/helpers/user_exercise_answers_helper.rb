module UserExerciseAnswersHelper

    def get_answer(user, exercise)
       @answer = UserExerciseAnswer.where(user_id: user, exercise_id: exercise).take
       @answer = UserExerciseAnswer.new(user_id: user, exercise_id: exercise) unless @answer

       @answer
    end

end
