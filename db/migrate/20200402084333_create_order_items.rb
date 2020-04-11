class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :count
      t.integer :production_status, default: 0
      t.integer :tax_included_price
      t.timestamps
    end
  end
end
