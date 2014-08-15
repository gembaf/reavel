class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :login_check, unless: :login_action?

  private
  def login_check
    redirect_to login_path if session[:admin_id].nil?
  end

  def login_action?
    self.controller_name == 'sessions'
  end
end

