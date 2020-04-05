class User::UsersController < ApplicationController

  def top
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

end
