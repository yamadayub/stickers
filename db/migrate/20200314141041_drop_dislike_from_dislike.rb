class DropDislikeFromDislike < ActiveRecord::Migration[5.2]
  def change
    remove_column :dislikes, :dislike
  end
end
