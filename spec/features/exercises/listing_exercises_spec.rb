require 'rails_helper'

RSpec.feature 'Listing Exercises' do
  before do
    @zoe = User.create!(
      first_name: 'Zoe',
      last_name: 'Bandera',
      email: 'zoe@example.com',
      password: 'password'
    )
    login_as(@zoe)

    @exercise1 = @zoe.exercises.create(
      duration_in_min: 20,
      workout: 'Yoga',
      workout_date: Date.today
    )
    @exercise2 = @zoe.exercises.create(
      duration_in_min: 55,
      workout: 'Weight lifting',
      workout_date: 2.days.ago
    )
    @exercise3 = @zoe.exercises.create(
      duration_in_min: 60,
      workout: 'Running',
      workout_date: 8.days.ago
    )
  end

  scenario "shows user's workout for last 7 days" do
    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content(@exercise1.duration_in_min)
    expect(page).to have_content(@exercise1.workout)
    expect(page).to have_content(@exercise1.workout_date)

    expect(page).to have_content(@exercise2.duration_in_min)
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_content(@exercise2.workout_date)

    expect(page).not_to have_content(@exercise3.duration_in_min)
    expect(page).not_to have_content(@exercise3.workout)
    expect(page).not_to have_content(@exercise3.workout_date)
  end

  scenario 'shows no exercises if none created' do
    @zoe.exercises.delete_all

    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content('No Workouts Yet')
  end
end
