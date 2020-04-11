class User::OrdersController < ApplicationController

  def index
    @order = Order.find(params[:id])
    @user = current_user
    orders = current_user.orders
    cart_items = current_user.cart_items
    @total = 0
    cart_items.each do |cart_item|
      @total += (cart_item.product.price * cart_item.product.tax_rate).round * cart_item.count
    end
  end

  def new
    @order = Order.new
    @user = User.find(params[:user_id])
  end

  def confirm
    @order = Order.new(order_params)
    @user = User.find(params[:user_id])
    # ご自身の住所を選択した場合
    if params[:addresses] == "1"
      @order.post_number = @user.post_number
      @order.post_address = @user.address
      @order.post_name = @user.first_name_kanji + @user.last_name_kanji
    # 登録済住所から選択する場合
    elsif params[:addresses] == "2"
      @delivery = Delivery.find(params[:@registered_deliveries][:registered_deliveries])
      @order.post_number = @delivery.post_number
      @order.post_address = @delivery.post_address
      @order.post_name = @delivery.post_name
    end
    #新しいお届け先を選択した場合(if params[:addresses] == "3"はいらない？)
  end

  def create
    @order = Order.new(order_params)
    @user = User.find(params[:user_id])
    @order.user_id = @user.id
    if @order.save
      redirect_to user_thanks_path
    else
      @user = User.find(params[:user_id])
      render :new
    end
  end

  def thanks
  end

  def show
    @user = current_user
    orders = current_user.orders
    cart_items = current_user.cart_items
    @total = 0
    cart_items.each do |cart_item|
      @total += (cart_item.product.price * cart_item.product.tax_rate).round * cart_item.count
    end
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :postage, :total_price, :request_status, :post_number, :post_address, :post_name, :post_phone_number, :payment_method)
  end

end
