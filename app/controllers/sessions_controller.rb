class SessionsController < ApplicationController
  layout "user", except: []

  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      login_as(user, params[:remember_me])
      redirect_to tasks_path, flash: { success: "登录成功！" }
    else
      flash.now.alert = "无效的邮箱或密码！"
      render "new"
    end
  end

  def destroy
    cookies.delete(:user)
    redirect_to root_url, flash: { success: "退出成功！" }
  end
end
