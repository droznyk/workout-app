require 'rails_helper'

RSpec.feature 'Showing friend workout' do
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

    @exercise1 = @matthew.exercises.create(
      duration_in_min: 20,
      workout: 'Yoga',
      workout_date: Date.today
    )
  end

  scenario "shows friend's workout for last 7 days" do
    visit '/'

    click_link 'My Lounge'
    click_link @matthew.full_name

    expect(page).to have_content("#{@matthew.full_name}'s Exercises")
    expect(page).to have_content(@exercise1.workout)
    expect(page).to have_css('div#chart')
  end
end
