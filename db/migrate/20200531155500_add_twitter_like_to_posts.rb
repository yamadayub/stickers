class AddTwitterLikeToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :like_in_twitter, :integer
  end
end
