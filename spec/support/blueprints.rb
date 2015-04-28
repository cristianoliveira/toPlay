require 'machinist/active_record'

User.blueprint do
  email        { Faker::Internet.email }
  password     { Faker::Internet.password }
  confirmed_at { 1.week.ago }
end

Identity.blueprint do
  user { User.make! }
  uid  { "uid#{sn}" }
  provider { 'facebook' }
end

Course.blueprint do
  # Attributes here
end

Subject.blueprint do
  # Attributes here
end

Level.blueprint do
  # Attributes here
end

Topic.blueprint do
  # Attributes here
end

Video.blueprint do
  # Attributes here
end

Resume.blueprint do
  # Attributes here
end

Exercise.blueprint do
  # Attributes here
end

Alternative.blueprint do
  # Attributes here
end

Question.blueprint do
  # Attributes here
end

AdminUser.blueprint do
  # Attributes here
end

UserExerciseAnswer.blueprint do
  # Attributes here
end

# Notifications.blueprint do
#   # Attributes here
# end
