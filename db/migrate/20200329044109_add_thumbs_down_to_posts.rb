class AddThumbsDownToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :thumbsdown, :integer
  end
end
