FactoryGirl.define do
  factory :course do
    name "Course 1"
  end

  factory :subject do
    course
    name "Subject 1 for Coures 1"
  end

  factory :level do
    subject
    name "Level 1 for Subject 1"
  end

  factory :topic do
    level
    name "Topic 1 for Level 1"
  end

end
