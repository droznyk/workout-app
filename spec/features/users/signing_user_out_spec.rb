require 'rails_helper'

RSpec.describe 'Sign out user' do
  before do
    @zoe = User.create!(first_name: 'Zoe', last_name: 'Bandera', email: 'zoe@example.com', password: 'password')
    login_as(@zoe)
  end

  scenario 'with success' do
    visit '/'

    click_link 'Log out'

    expect(page).to have_content('Signed out successfully')
    expect(page).to have_content('Log in')
    expect(page).to have_content('Sign up')
  end
end
