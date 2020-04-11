class OrderItem < ApplicationRecord
	belongs_to :order
	belongs_to :product
	enum production_status:{ 着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3}

	def sub_total_price(order_item)
		tax_included_price * order_item.count
	end


	def production_status_average
		Order_item.average(:production_status)
	end
	# def production_status_average
	# 	array { |order_item| order_item.production_status }
	# end
end
