class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|
      t.integer :count
      t.integer :product_id
      t.integer :user_id
      t.timestamps
    end
  end
end
