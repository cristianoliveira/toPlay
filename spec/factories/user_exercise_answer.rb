FactoryGirl.define do
  factory :user_exercise_answer do
    user
    exercise
    alternative
  end
end
