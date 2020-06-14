class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters,if: :devise_controller?
  before_action :set_search

  def set_search
    if params[:q].present? # qが空だとエラーがでるから分岐させる。
      # 検索フォームからアクセスした時の処理
        @search = Video.ransack(params[:q])
      else
      # 検索フォーム以外からアクセスした時の処理。
        params[:q] = { sorts: 'updated_on asc' }
        @search = Video.ransack()
      end
  end

  private
  # ユーザーの登録時にnameを入力することを許可するもの
  def configure_permitted_parameters
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name,:email, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:name,:email, :password, :password_confirmation) }
  end
end
