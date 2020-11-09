class AddStyleToRooms < ActiveRecord::Migration[5.2]
  def up
    add_column :rooms, :style_sheet, :string
  end
  def down
    remove_column :rooms, :style_sheet, :string
  end
end
