class Admin::UsersController < ApplicationController

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
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:first_name_kanji, :last_name_kanji, :first_name_kana, :last_name_kana, :post_number, :address, :phone_number, :email)
  end

end