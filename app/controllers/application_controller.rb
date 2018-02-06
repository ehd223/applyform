class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  def current_user
    @current_user ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end
  helper_method :current_user

  def authorize
    redirect_to '/apply/login' unless current_user
  end

end
