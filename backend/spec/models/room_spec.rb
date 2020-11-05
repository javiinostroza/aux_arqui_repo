require 'spec_helper'

RSpec.describe Room, type: :model do
  context 'when a user create a room' do
    it 'ensures the room creation' do
      room = Room.create(name: 'roomname').save
      expect(room).to eq(true)
    end
  end
end