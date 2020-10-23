class RoomMessage < ApplicationRecord
  belongs_to :room, touch: false, inverse_of: :room_messages
  belongs_to :user

end
