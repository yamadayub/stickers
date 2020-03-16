class ChangeColumnNameToDislike < ActiveRecord::Migration[5.2]
  def change
    rename_column :dislikes, :delete, :dislike
  end
end
