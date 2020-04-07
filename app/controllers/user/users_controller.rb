class User::UsersController < ApplicationController

  def top
    @randoms = Product.order("RANDOM()").limit(4)
    @genres = Genre.where(active_status: 0)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
  end

  def confirm
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
   end

end