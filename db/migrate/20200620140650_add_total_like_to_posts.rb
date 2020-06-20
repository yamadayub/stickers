class AddTotalLikeToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :total_net_like, :integer
  end
end
