class AddRoomToRequests < ActiveRecord::Migration[5.2]
  def change
    add_reference :requests, :room, foreign_key: true
  end
end
