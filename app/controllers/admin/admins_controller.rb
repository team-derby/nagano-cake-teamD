class Admin::AdminsController < ApplicationController

  before_action :authenticate_admin!

	def top
		@today = Date.today
		@orders = Order.all
		@today_count = @orders.where(created_at: @today.all_day).count
	end

end
