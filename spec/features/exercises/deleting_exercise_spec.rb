require 'rails_helper'

RSpec.feature 'Deleting Exercise' do
  before do
    @owner = User.create!(email: 'owner@example.com', password: 'password')
    @owner_exercise = @owner.exercises.create!(duration_in_min: 48,
                                                workout: 'My body building activity',
                                                workout_date: Date.today)
    login_as(@owner)
  end

  scenario 'with success' do
    visit '/'

    click_link 'My Lounge'

    click_link 'Destroy'

    expect(page).to have_content('Exercise has been deleted')
    expect(@owner.exercises.count).to eq 0
  end
end
