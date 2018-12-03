require 'rails_helper'

RSpec.feature 'Listing user friends' do
  before do
    @zoe = User.create!(
      first_name: 'Zoe',
      last_name: 'Hellski',
      email: 'zoe@example.com',
      password: 'password'
    )
    @matthew = User.create!(
      first_name: 'Matthew',
      last_name: 'Murdock',
      email: 'matt@example.com',
      password: 'password'
    )
    login_as(@zoe)
    @following = Friendship.create(user: @zoe, friend: @matthew)
  end

  scenario "shows a list of user's friend" do
    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content('My friends')
    expect(page).to have_link(@matthew.full_name)
    expect(page).to have_link('Unfollow')
  end
end
