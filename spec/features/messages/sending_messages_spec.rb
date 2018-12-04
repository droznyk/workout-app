require 'rails_helper'

RSpec.feature 'Sending a message' do
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
    @trevor = User.create!(
      first_name: 'Trevor',
      last_name: 'Dallas',
      email: 'trevor@example.com',
      password: 'password'
    )
    @room_name = @zoe.full_name.split.join('-')
    @room = Room.create!(name: @room_name, user_id: @zoe.id)
    login_as(@zoe)
    Friendship.create(user: @matthew, friend: @zoe)
    Friendship.create(user: @trevor, friend: @zoe)
  end

  scenario 'to followers shows in chatroom window' do
    visit '/'

    click_link 'My Lounge'
    expect(page).to have_content(@room_name)

    fill_in "message-field",	with: "Hello"
    click_button 'Post'

    expect(page).to have_content('Hello')

    within('#followers') do
      expect(page).to have_link(@matthew.full_name)
      expect(page).to have_link(@trevor.full_name)
    end
  end
end
