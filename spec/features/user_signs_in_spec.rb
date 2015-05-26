require 'spec_helper'

feature "Signing in" do
  let(:user) { Fabricate(:user) }
  
  scenario "Signing in with correct credentials" do
    visit root_path
    within("p.sign_in") { click_link "Sign In" }
    sign_in_user(user)
    expect(page).to have_content user.full_name
  end
  
  scenario "Signing in with incorrect credentials" do
    visit root_path
    within("p.sign_in") { click_link "Sign In" }
    fill_in "Email Address", with: user.email
    fill_in "Password", with: "this is the wrong password"
    click_button "Sign in"
    expect(page).to have_content "Invalid email or password"
  end
end