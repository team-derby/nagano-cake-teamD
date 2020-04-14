class User::CartItemsController < ApplicationController

  before_action :authenticate_user!
  before_action :baria_user

  def index
    @user = current_user
    cart_items = current_user.cart_items
    @total = 0
    cart_items.each do |cart_item|
      @total += (cart_item.product.price * cart_item.product.tax_rate).round * cart_item.count
    end
  end

  def create
    # Cart.newにcountの値を入れる(ストロングパラメータ使う？)
    @cart_item = CartItem.new(cart_params)

    # user_idの値を設定する
    @cart_item.user_id = current_user.id

    # product_idの値を設定する
    # 下の行を使う場合、上の(cart_params)を消す(updateアクションを2回処理してしまうため)
    # @cart_item.product_id = params[:cart_item][:product_id].to_i

    # もしproduct_idとuser_idを持つcart_itemが既に存在する場合の処理
    if CartItem.find_by(user_id: current_user, product_id: @cart_item.product_id)
      # 上記の物を、下の変数の中に再定義
      @existing_cart_item = CartItem.find_by(user_id: current_user, product_id: @cart_item.product_id)
      # 既に存在するcart_itemの個数に、これから追加されるcart_itemの個数を足す処理
      @existing_cart_item.count += @cart_item.count
      # saveする（厳密には、updateを書くと引数が必要なため、saveを書いてupdateの処理をする)
      @existing_cart_item.save!
      # redirectする
      redirect_to user_user_cart_items_path
    else
      # saveする
      @cart_item.save!
      # redirectする
      redirect_to user_user_cart_items_path
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_params)
    # ajaxを発火させるためredirectは削除
    # renderでindexに飛ぶのに＠@user、@totalを表示するのに必要名ため追記(indexと同じ内容)
    @user = current_user
    cart_items = current_user.cart_items
    @total = 0
    cart_items.each do |cart_item|
      @total += (cart_item.product.price * cart_item.product.tax_rate).round * cart_item.count
    end

  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    # ajaxを発火させるためredirectは削除
    # renderでindexに飛ぶのに＠@user、@totalを表示するのに必要名ため追記(indexと同じ内容)
    @user = current_user
    cart_items = current_user.cart_items
    @total = 0
    cart_items.each do |cart_item|
      @total += (cart_item.product.price * cart_item.product.tax_rate).round * cart_item.count
    end
  end

  def destroy_all
    cart_items = current_user.cart_items
    cart_items.each do |cart_item|
      cart_item.destroy
    end
    redirect_to user_user_cart_items_path
  end

  private

  def cart_params
    params.require(:cart_item).permit(:count, :product_id)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
    unless params[:user_id].to_i == current_user.id
      redirect_to user_root_path
    end
   end

end