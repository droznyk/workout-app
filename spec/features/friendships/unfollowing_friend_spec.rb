require 'rails_helper'

RSpec.feature 'Unfollowing friend' do
  before do
    @zoe = User.create!(
      first_name: 'Zoe',
      last_name: 'Bandera',
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

  scenario 'unfollows friend with success' do
    visit '/'

    click_link 'My Lounge'

    link = "a[href='/friendships/#{@following.id}'][data-method='delete']"
    find(link).click

    friendship = @zoe.friendships.where(friend: @matthew)
    expect(page).to have_content("#{@matthew.full_name} unfollowed")
    expect(friendship.empty?).to be true
  end
end
