class AddPasswordToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :password, :string
  end
  def down
    remove_column :users, :password, :string
  end
end
