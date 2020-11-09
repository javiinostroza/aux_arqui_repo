class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.string :url
      t.boolean :accepted

      t.timestamps
    end
  end
end
