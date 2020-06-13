class AddUsernameToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :twitter_usermane, :string
  end
end
