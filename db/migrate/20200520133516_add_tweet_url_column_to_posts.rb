class AddTweetUrlColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :tweet_url, :string
  end
end
