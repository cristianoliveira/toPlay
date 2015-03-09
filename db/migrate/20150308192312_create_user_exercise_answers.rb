class CreateUserExerciseAnswers < ActiveRecord::Migration
  def change
    create_table :user_exercise_answers do |t|
      t.references :user, index: true
      t.references :exercise, index: true
      t.references :alternative, index: true

      t.timestamps
    end
  end
end
