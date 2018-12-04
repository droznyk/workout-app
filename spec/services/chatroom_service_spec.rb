require 'rails_helper'

RSpec.describe ChatroomService do
  describe '.create' do
    let(:user) { User.create!(
      first_name: 'Zoe',
      last_name: 'Hellski',
      email: 'zoe@example.com',
      password: 'password'
    ) }
    subject { described_class.create(user) }
    it { expect{ subject }.to change{ Room.count }.from(0).to(1) }
  end
end
