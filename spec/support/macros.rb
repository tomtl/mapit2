def set_current_user(user = nil)
  session[:user_id] = (user ||= Fabricate(:user).id)
end

def sign_in_user(user = nil)
  user ||= Fabricate(:user)
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def valid_address
  "742 E Evergreen St, Springfield, MO 65803"
end