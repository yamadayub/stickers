class AddTweetDetailColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :profile_image_url, :string
    add_column :posts, :text, :string
    add_column :posts, :net_thumbs, :integer
  end
end
