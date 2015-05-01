FactoryGirl.define do

  sequence :email do |n|
    "email#{n}@factory.com"
  end

  factory :user do
    email
    first_name  "test"
    last_name   "fake"
    password    "123123"
    confirmed_at Date.today #confirmed
  end

  factory :admin , class: User do
    email     
    first_name  "test_admin"
    last_name   "fake_admin"
    password    "123123"
    confirmed_at Date.today #confirmed
    role :administrator
  end

end
