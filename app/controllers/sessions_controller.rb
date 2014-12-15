class SessionsController < ApplicationController
  def new
  end

  def login
    attr = admin_params
    admin = Admin.where(name: attr[:name]).first
    if admin && admin.authenticate(attr[:password])
      session[:admin_id] = admin.id
      redirect_to mains_path and return
    else
      flash.now.alert = "ログイン失敗"
      render :new
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to login_path
  end

  private
  def admin_params
    params.require(:admin).permit(:name, :password)
  end
end

