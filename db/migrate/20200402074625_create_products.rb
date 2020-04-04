class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genre_id
      t.string :name
      t.text :explanation
      t.integer :price
      t.float :tax_rate
      t.string :image_id
      t.integer :sales_status
      t.timestamps
    end
  end
end
