class User::DeliveriesController < ApplicationController

  before_action :authenticate_user!
  before_action :baria_user

  def index
    @delivery = Delivery.new
    @user = User.find(params[:user_id])
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.user_id = current_user.id
    if @delivery.save
      redirect_to request.referer, notice: "配送先の作成が完了しました！"
    else
      @user = User.find(params[:user_id])
      render :index
    end
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to user_user_deliveries_path(user_id: current_user.id), notice: "配送先の編集が完了しました！"
    else
      render :edit
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to request.referer, notice: "配送先の削除が完了しました！"
  end

  private

  def delivery_params
    params.require(:delivery).permit(:user_id, :post_number, :post_address, :post_name, :post_phone_number)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
    unless params[:user_id].to_i == current_user.id
      redirect_to user_root_path
    end
   end

end
