class User::UsersController < ApplicationController
  git
  def top
  end
  
  def show
  end

  def update
      if current_user.update(user_params)
         redirect_to root_path #更新できた場合はTOP画面へ
      else
         render :edit #更新できない場合は編集画面に戻る
      end
  end

  def edit
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
