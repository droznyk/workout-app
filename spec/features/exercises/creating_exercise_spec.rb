require 'rails_helper'

RSpec.describe 'Creating exercise' do
  before do
    @zoe = User.create!(first_name: 'Zoe', last_name: 'Bandera', email: 'zoe@example.com', password: 'password')
    login_as(@zoe)

    visit '/'

    click_link 'My Lounge'
    click_link 'New Workout'
    expect(page).to have_link('Back')
  end

  scenario 'with valid credentials' do
    fill_in 'Duration',	with: 70
    fill_in 'Workout details',	with: 'Weight lifting'
    fill_in 'Activity date',	with: 3.days.ago
    click_button 'Create Exercise'

    expect(page).to have_content('Exercise has been created')
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@zoe, exercise))
    expect(exercise.user_id).to eq(@zoe.id)
  end

  scenario 'with invalid credentials' do
    fill_in 'Duration',	with: 'anything'
    fill_in 'Workout details',	with: ''
    fill_in 'Activity date',	with: ''
    click_button 'Create Exercise'

    expect(page).to have_content('Exercise has not been created')
    expect(page).to have_content('Duration in min is not a number')
    expect(page).to have_content("Workout details can't be blank")
    expect(page).to have_content("Activity date can't be blank")
    # expect(current_path).to eq(new_user_exercise_path(@zoe)) todo: fixing
    expect(Exercise.count).to eq 0
  end
end
