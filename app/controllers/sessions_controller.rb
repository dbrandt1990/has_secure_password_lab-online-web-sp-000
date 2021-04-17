class SessionsController < ApplicationController

  def new
    render login_path
  end

  def create
      @user = User.find_by(name: params[:user][:name])
      if @user.nil?
        redirect_to "/users/signup", alert: 'No user found, please sign up'
      else
        return head(:forbidden) unless @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect_to "/users/show"
      end
  end
end
