class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :login_check, unless: :session_controller?

  def login_check
    redirect_to login_path unless session[:admin_id]
  end

  private
  def session_controller?
    controller_name == "sessions"
  end
end

