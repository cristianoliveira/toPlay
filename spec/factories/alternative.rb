FactoryGirl.define do
  factory :alternative do
    id 1
    correct true
  end

  factory :alternative_incorrect, class: Alternative do
    id 2
    correct false
  end
end
