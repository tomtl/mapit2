require 'spec_helper'

feature "User creates location" do
  scenario "User creates location and interacts with it" do
    address = valid_address

    visit sign_in_path
    sign_in_user
    
    fill_in "Add new address:", with: address
    click_button "Add address"

    expect(page).to have_content("Your location has been created")
    expect(page).to have_content(address)
    
    click_link address
    expect(page).to have_content(address)
    expect(page).to have_content("Edit address")
    expect(page).to have_content("Delete address")
    
    click_link "Delete address"
    expect(page).to have_content("Address has been deleted successfully")
    expect(page).not_to have_content(address)
  end
end