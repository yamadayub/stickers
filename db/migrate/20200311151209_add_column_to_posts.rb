class AddColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :posts, :users
    remove_index :posts, :user_id
    remove_reference :posts, :user
    
    add_column :posts, :tweet_id, :string
  end
end
