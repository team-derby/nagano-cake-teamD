class User::UsersController < ApplicationController

  before_action :baria_user, except: [:top, :about, :confirm]

  def top
    @randoms = Product.includes(:genre).where(genres: { active_status: "0"}).order("RANDOM()").limit(4)
    @genres = Genre.where(active_status: 0)
  end

  def about
    @map_address = "長野市大字北尾張部３９７−１"
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_user_path(@user),notice: "編集が完了しました！"
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.update(profile_status: '退会済')
    sign_out @user
      redirect_to user_root_path,notice: "退会が完了しました！"
  end

  def confirm
    @user = User.find(current_user.id)
  end

  private
  def user_params
    params.require(:user).permit(:first_name_kanji, :last_name_kanji, :first_name_kana, :last_name_kana, :post_number, :address, :phone_number, :email)
  end

  def authenticate_team!
    @user = User.find(current_user.id)
    return unless user_signed_in? && @user.profile_status?
    sign_out
    flash[:alert] = "Your account has already been deleted."
    redirect_to new_user_session_path
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
    unless params[:id].to_i == current_user.id
      redirect_to user_root_path
    end
   end

end
