require 'rails_helper'

RSpec.describe 'Sign up user' do
  scenario 'with valid credentials' do
    visit '/'

    click_link 'Sign up'

    fill_in "Email",	with: "john@example.com" 
    fill_in "Password",	with: "password" 
    fill_in "Password confirmation",	with: "password" 
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")
    expect(User.last.email).to eq("john@example.com")  
  end

  scenario 'with invalid credentials' do
    visit '/'

    click_link 'Sign up'

    fill_in "Email",	with: ""
    fill_in "Password",	with: ""
    fill_in "Password confirmation",	with: ""
    click_button "Sign up"

    expect(page).to have_content("prohibited this user from being saved")
    expect(User.count).to eq 0
  end
end
