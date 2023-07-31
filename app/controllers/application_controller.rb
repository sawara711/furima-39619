class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  # 新規登録時のストロングパラメーターを設定
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :surname, :givenname, :surname_kana, :givenname_kana, :birthday])
  end
end
