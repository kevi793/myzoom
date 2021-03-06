class UsersController < ApplicationController


  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
      @user = User.create(user_params)
      @user.password = @user[:password_digest]
      if @user.save
        flash[:success] = 'Welcome to MyZoom'
        sign_in @user
        redirect_to @user
      else
        render 'new'
      end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password_digest, :remember_token)
  end



end
