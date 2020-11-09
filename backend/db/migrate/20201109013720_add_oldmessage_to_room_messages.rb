class AddOldmessageToRoomMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :room_messages, :oldmessage, :string
  end
end
