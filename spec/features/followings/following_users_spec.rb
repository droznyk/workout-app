require 'rails_helper'

RSpec.feature 'Following users' do
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
  end

  scenario 'if user signed in' do
    visit '/'

    expect(page).to have_content(@zoe.full_name)
    expect(page).to have_content(@matthew.full_name)

    href = "/friendships?friend_id=#{@zoe.id}"
    expect(page).not_to have_link('Follow', href: href)

    link = "a[href='/friendships?friend_id=#{@matthew.id}']"
    find(link).click

    href = "/friendships?friend_id=#{@matthew.id}"
    expect(page).not_to have_link('Follow', href: href)
  end

  scenario 'if user not signed in' do
    logout

    visit '/'

    expect(page).not_to have_link 'Follow'
  end
end
