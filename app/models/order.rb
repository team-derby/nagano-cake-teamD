class Order < ApplicationRecord
	belongs_to :user
	has_many :order_items, dependent: :destroy
	enum request_status:{ 入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4 }
	enum payment_method:{ クレジットカード: 0, 銀行振込: 1}


	def products_total_price
		order_items.to_a.sum { |order_item| order_item.sub_total_price }
	end

	def total_count
		order_items.to_a.sum { |order_item| order_item.count }
	end
end
