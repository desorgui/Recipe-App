class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :handle_auth_error

  protect_from_forgery with: :null_session
  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password)
    end
  end

  # before_action :authenticate_user!

  # before_action :configure_permitted_parameters, if: :devise_controller?
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  # end

  def handle_auth_error
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'You are not authorized to complete this action.' }
    end
  end
end
