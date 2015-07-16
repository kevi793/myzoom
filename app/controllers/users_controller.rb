class UsersController < ApplicationController
  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
  end

  def create
      @user = User.new(user_params)
      if @user.save
        #Successful save
        flash[:success] = 'Welcome to MyZoom'
        redirect_to @user
      else
        render 'new'
      end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password_digest)
  end
end
