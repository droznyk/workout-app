require 'rails_helper'

RSpec.feature 'Listing Members at homepage' do
  before do
    @zoe = User.create!(
      first_name: 'Zoe',
      last_name: 'Banks',
      email: 'zoe@example.com',
      password: 'password'
    )
    @matthew = User.create!(
      first_name: 'Matthew',
      last_name: 'Connors',
      email: 'matthew@example.com',
      password: 'password'
    )
  end

  scenario 'shows a list of registered members' do
    visit '/'

    expect(page).to have_content('List of Members')
    expect(page).to have_content(@zoe.full_name)
    expect(page).to have_content(@matthew.full_name)
  end
end
