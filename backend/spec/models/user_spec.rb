require 'spec_helper'

RSpec.describe User, type: :model do
  context 'when user is registered with username' do
    it 'ensures username presence' do
      user = User.create(username: 'name')
      expect(user.username).to eq('name')
    end
  end
end