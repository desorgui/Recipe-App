class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied, with: :handle_auth_error

  def handle_auth_error
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'You are not authorized to complete this action.' }
    end
  end
end
