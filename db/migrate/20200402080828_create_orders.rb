class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :postage, default: 1.08
      t.integer :total_price
      t.integer :request_status
      t.string :post_number
      t.string :post_address
      t.string :post_name
      t.string :post_phone_number
      t.integer :payment_method
      t.timestamps
    end
  end
end
