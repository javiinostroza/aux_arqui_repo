class AddPhotoUrlToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :thumbnail_url, :string, :null => false, :default => "https://chatroom-profileimg-resized.s3-us-west-2.amazonaws.com/user.svg"
  end
end
