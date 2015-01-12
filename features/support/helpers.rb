def to_url string
  return root_path if string == "the homepage"
  raise "Sorry dude but I don't know what '#{string}' means"
end

def to_link string
  return "login" if string == "the login link"
  return "signup_link" if string == "the signup link"
  raise "Sorry dude but I don't know what '#{string}' means"
end

def to_element string
  string
end

def to_button string
  return 'login_submit' if string == 'the submit login button'
end

def to_text string
  return @user.email if string == "this user's email"
  return @user.password if string == "this user's password"
  string
end
