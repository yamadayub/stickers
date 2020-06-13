class ChangeColumnNameInPost < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :twitter_usermane, :twitter_usernane
  end
end
