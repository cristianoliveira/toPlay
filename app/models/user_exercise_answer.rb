class UserExerciseAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :exercise
  belongs_to :alternative

  def correct?
    self.alternative.correct
  end
end
