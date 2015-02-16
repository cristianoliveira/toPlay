FactoryGirl.define do
  factory :user do
    email       "email@test.com"
    first_name  "test"
    last_name   "fake"
    password    "123123"
    confirmed_at Date.today #confirmed
  end

  factory :admin , class: User do
    email       "admin@test.com"
    first_name  "test_admin"
    last_name   "fake_admin"
    password    "123123"
    confirmed_at Date.today #confirmed
    role :administrator

  end

end