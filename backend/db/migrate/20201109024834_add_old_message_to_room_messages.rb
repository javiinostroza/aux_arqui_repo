class AddOldMessageToRoomMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :room_messages, :old_message, :text
  end
end
