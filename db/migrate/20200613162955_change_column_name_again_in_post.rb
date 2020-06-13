class ChangeColumnNameAgainInPost < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :twitter_usernane, :twitter_username
  end
end
