class Admin::UsersController < ApplicationController

  before_action :authenticate_user!

  def index
    @users = User.all
    @user = User.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user),notice: "編集が完了しました！"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.update(profile_status: '退会済')
      redirect_to admin_user_path
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:first_name_kanji, :last_name_kanji, :first_name_kana, :last_name_kana, :post_number, :address, :phone_number, :email, :profile_status)
  end

end