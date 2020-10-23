class AddEmailToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :email, :string
  end
  def down
    remove_column :users, :email, :string
  end
end
