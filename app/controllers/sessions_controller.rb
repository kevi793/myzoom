class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.find_by(:email => params[:session][:email].downcase)
    user_authenticate = user.authenticate(params[:session][:password])
    if user_authenticate
      sign_in user
      redirect_to user
    else
      flash[:error] = "Invalid email/password combination"
      redirect_to '/signin'
    end
  end

  def signout
    sign_out
    redirect_to root_path
  end

end
