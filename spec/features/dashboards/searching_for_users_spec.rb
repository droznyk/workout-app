require 'rails_helper'

RSpec.feature 'Searching for User' do
  before do
    @zoe = User.create!(
      first_name: 'Zoe',
      last_name: 'Bandera',
      email: 'zoe@example.com',
      password: 'password'
    )
    @matthew = User.create!(
      first_name: 'Matthew',
      last_name: 'Bandera',
      email: 'matthew@example.com',
      password: 'password'
    )
  end

  scenario 'with existing name returns all those users' do
    visit '/'

    fill_in "search_name",	with: "Bandera"
    click_button "Search"

    expect(page).to have_content(@zoe.full_name)
    expect(page).to have_content(@matthew.full_name)
    expect(current_path).to eq('/dashboards/search')
  end

  scenario 'with non-existing name returns no users found' do
    visit '/'

    fill_in "search_name",	with: "Eliott"
    click_button 'Search'

    expect(page).to have_content('No users found')
    expect(page).not_to have_content(@zoe.full_name)
    expect(page).not_to have_content(@matthew.full_name)
  end
end
