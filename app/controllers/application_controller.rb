class ApplicationController < ActionController::Base

  $g_is_deleted = false

  before_action :configure_permitted_parameters, if: :devise_controller?
  #デバイス機能実行前にconfigure_permitted_parametersの実行をする。
  protect_from_forgery with: :exception
  before_action :set_search

  def set_search
    @q = Product.ransack(params[:q])
  end

  protected
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_admins_top_path
    when User
      user_root_path
    end
  end
  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    if $g_is_deleted
      $g_is_deleted = false
      new_user_registration_path
    else
      user_root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name_kanji, :last_name_kanji, :first_name_kana, :last_name_kana, :post_number, :address, :phone_number])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :encrypted_password])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
  end
end
