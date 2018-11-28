require 'rails_helper'

RSpec.describe 'Visiting homepage' do
  scenario 'user successfully visits the homepage' do
    visit '/'

    expect(page).to have_link("Home")
    expect(page).to have_link("Athletes Den")
    expect(page).to have_content("Workout Lounge!")
    expect(page).to have_content("Show off your workout")
  end
end
