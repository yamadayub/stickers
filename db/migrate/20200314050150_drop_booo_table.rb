class DropBoooTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :booos
  end
end
