require 'rails_helper'

RSpec.describe 'Sign in user' do
  before do
    @zoe = User.create!(first_name: 'Zoe', last_name: 'Bandera', email: 'zoe@example.com', password: 'password')
  end

  scenario 'with valid credentials' do
    visit '/'

    click_link 'Log in'

    fill_in 'Email',	with: @zoe.email
    fill_in 'Password',	with: @zoe.password
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content("Signed in as #{@zoe.email}")
    expect(page).to have_link('Log out')
    expect(page).not_to have_link('Log in')
    expect(page).not_to have_link('Sign up')
  end

  scenario 'with invalid credentials' do
    visit '/'

    click_link 'Log in'

    fill_in 'Email',	with: ''
    fill_in 'Password',	with: ''
    click_button 'Log in'

    expect(page).to have_content('Invalid Email or password')
    expect(page).to have_link('Log in')
    expect(page).to have_link('Sign up')
  end
end
