# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  config.add_observer 'ReputationChangeObserver'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  config.user_model_name = 'User'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  config.current_user_method = 'current_user'
end

# Create application badges (uses https://github.com/norman/ambry)
# badge_id = 0
# [{
#   id: (badge_id = badge_id+1),
#   name: 'just-registered'
# }, {
#   id: (badge_id = badge_id+1),
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# }].each do |attrs|
#   Merit::Badge.create! attrs
# end

Merit::Badge.create!(
  id: 1,
  name: "Novato",
  description: "Só o começo..."
)

Merit::Badge.create!(
  id: 2,
  name: "Junior",
  description: "Usuário participativo."
)

Merit::Badge.create!(
  id: 3,
  name: "Esforçado",
  description: "Usuário colabora com a comunidade."
)

Merit::Badge.create!(
  id: 4,
  name: "Nerd",
  description: "Usuário participativo."
)

Merit::Badge.create!(
  id: 5,
  name: "Ninja",
  description: "Ninja."
)
