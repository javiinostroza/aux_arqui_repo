require 'spec_helper'

RSpec.describe RoomMessage, type: :model do
  context 'when a user send a message' do
    it 'ensures message is not empty' do 
      message = RoomMessage.create(message: 'Hola mundo!')
      expect(message.message).not_to be_empty
    end
  end
end