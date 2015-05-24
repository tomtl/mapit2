class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_user
    if !current_user
      flash[:error] = "Please log in."
      redirect_to sign_in_path unless current_user
    end
  end

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
