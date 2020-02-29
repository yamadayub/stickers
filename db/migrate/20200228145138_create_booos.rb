class CreateBooos < ActiveRecord::Migration[5.2]
  def change
    create_table :booos do |t|
      t.references :post, foreign_key: true
      t.boolean :boo

      t.timestamps
    end
  end
end
