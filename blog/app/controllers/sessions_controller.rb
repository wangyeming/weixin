class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
    if logged_in?
      redirect_to articles_url
    end
  end

  def create
    user = User.find_by(name: params[:name])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:remember_token] = user.id
      redirect_to admin_url
    else
      redirect_to root_url, alert: "用户名或密码错误"
    end
  end

  def destroy
    #Session.find(:user_id).destroy
    session[:user_id] = nil
    redirect_to root_url, notice:  "退出登录"
  end
end
