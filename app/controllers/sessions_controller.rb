class SessionsController < ApplicationController
  def new
    redirect_to '/practices' if current_user
  end

  def create
    @user = User.find_by_account(params[:account])
    p @user
    if @user && password_match
      session[:user] = @user.id 
    else
      flash[:notice] = '帳號或密碼錯誤'
    end
    redirect_to '/practices'
  end

  def password_match
    require 'digest'
    @user.password == Digest::SHA256.hexdigest(params[:password])
  end

  def destroy
    session[:user] = nil
    redirect_to '/'
  end
end
