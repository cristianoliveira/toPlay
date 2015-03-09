class Alternative < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :user
  has_many :user_exercise_answer
end
