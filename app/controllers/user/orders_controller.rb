class User::OrdersController < ApplicationController

  def index
  end

  def new
    @order = Order.new
    @user = User.find(params[:user_id])
  end

  def confirm
    @order = Order.new(order_params)
    @user = User.find(params[:user_id])
    # 現在のユーザーのcart_items情報の取得(orderはcart_itemをリレーションがないためuserを介している。)
    @cart_items = CartItem.includes(:user).where(users: { id: current_user.id})
    # 商品合計の計算
    @total = 0
    @cart_items.each do |cart_item|
      @total += (cart_item.product.price * cart_item.product.tax_rate).round * cart_item.count
    end
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
    #新しいお届け先を選択した場合(if params[:addresses] == "3"はいらない
  end

  def create
    @order = Order.new(order_params)
    @user = User.find(params[:user_id])
    cart_items = CartItem.includes(:user).where(users: { id: current_user.id})
    @order.user_id = @user.id
    if @order.save
      # 注文が確定したらorder_itemsの作成
      cart_items.each do |cart_item|
      @order_items = OrderItem.new
      @order_items.order_id = @order.id
      @order_items.product_id = cart_item.product_id
      @order_items.count = cart_item.count
      @order_items.tax_included_price = (cart_item.product.price * cart_item.product.tax_rate).round
      @order_items.save
      # 注文が確定したらcart_itemの削除
      cart_item.destroy
      end
      redirect_to user_thanks_path
    else
      @user = User.find(params[:user_id])
      render :new
    end
  end

  def thanks
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :postage, :total_price, :request_status, :post_number, :post_address, :post_name, :post_phone_number, :payment_method)
  end

end
