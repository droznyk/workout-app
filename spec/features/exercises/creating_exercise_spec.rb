require 'rails_helper'

RSpec.describe 'Creating exercise' do
  before do
    @zoe = User.create!(email: 'zoe@example.com', password: 'password')
    login_as(@zoe)
  end

  scenario 'with valid credentials' do
    visit '/'

    click_link 'My Lounge'
    click_link 'New Workout'

    fill_in 'Duration',	with: 70
    fill_in 'Workout details',	with: 'Weight lifting'
    fill_in 'Activity date',	with: '2016-07-26'
    click_button 'Create Exercise'

    expect(page).to have_link('Back')
    expect(page).to have_content('Exercise has been created')
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@zoe, exercise))
    expect(exercise.user_id).to eq(@zoe.id)
  end
end
