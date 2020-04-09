class Admin::OrdersController < ApplicationController
	def index
		@orders = Order.all
	end
	def update
		@order = Order.find(params[:id])
		@order_items = Order_item.find(params[:id])
		if @order_items.update(order_params)
			production_status_average  = @order_items.average(:production_status)
	  		if production_status_average > 1
	  			Order.update_all ['request_status = ?', 2]
	  			redirect_to admin_product_path, notice: "successfully updated!"
	  		elsif production_status_average = 3
	  			Order.update_all ['request_status = ?', 4]
	  			redirect_to admin_product_path, notice: "successfully updated!"
	  		else
	  			redirect_to admin_product_path, notice: "successfully updated!"
	  		end
	  	elsif @order.update(order_params)
	  		if request_status = 1
	  			Order_item.update_all ['product_status = ?', 1]
	  			redirect_to admin_product_path, notice: "successfully updated!"
	  		elsif
	  			redirect_to admin_product_path, notice: "successfully updated!"
	  		end
	  	end
	end
	def show
		@order = Order.find(params[:id])
		@order_items = Order_item.find(params[:id])
	end
end
