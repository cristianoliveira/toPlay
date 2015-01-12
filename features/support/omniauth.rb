Before('@omniauth_test') do
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
    :provider => "facebook",
    :uid => "100001110497215",
    :info => {
      :email => "josias.ds@gmail.com",
      :first_name => "Josias",
      :last_name => "Schneider",
      :image => "http://www.gravatar.com/avatar/49ccdc86b38e617eba7631b0f901c5ef.png"
    },
    :credentials => {
      :token => "ASFGHJGHFGDSFDFGHDGF",
      :secret => "asasdasd"
    }
  )
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end
