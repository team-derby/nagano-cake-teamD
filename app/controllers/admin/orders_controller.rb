class Admin::OrdersController < ApplicationController

	before_action :authenticate_admin!

	def index
		@orders = Order.all
		orders = @user.orders
	end
	def update
		@order = Order.find(params[:id])
		@order_items = @order.order_items
		if params[:order_item] && update_order_item_params
			item_params = update_order_item_params
			order_item = OrderItem.find(item_params[:id])
			order_item.update(production_status:item_params[:production_status])
			production_status_average  = @order_items.average(:production_status)
	  		if production_status_average > 1 && production_status_average < 3
	  			@order.update(request_status: 2)
	  			redirect_to admin_order_path, notice: "successfully updated!"
	  		elsif production_status_average = 3
	  			@order.update(request_status: 3)
	  			redirect_to admin_order_path, notice: "successfully updated!"
	  		else
	  			redirect_to admin_order_path, notice: "successfully updated!"
	  		end
	  	elsif update_order_params
	  		order_request_params = update_order_params
	  		request_status = order_request_params[:request_status]
	  		@order.update(request_status:request_status)
	  		if request_status = 1
	  			OrderItem.where(['order_id = ?', params[:id]]).update_all ['production_status = ?', 1]
	  			redirect_to admin_order_path, notice: "successfully updated!"
	  		elsif
	  			redirect_to admin_order_path, notice: "successfully updated!"
	  		end
	  	end
	end
	def show
		@order = Order.find(params[:id])
		@order_items = @order.order_items
	end

	private
	def order_params
    params.require(:order).permit(:user_id, :postage, :total_price, :request_status, :post_address, :post_name, :payment_method)
  	end
  	def update_order_params
    params.require(:order).permit(:request_status)
  	end
  	def update_order_item_params
    params.require(:order_item).permit(:production_status, :id)
  	end
end