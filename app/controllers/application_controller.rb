class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters,if: :devise_controller?
  private
  # ユーザーの登録時にnameを入力することを許可するもの
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
