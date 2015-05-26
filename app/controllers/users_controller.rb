class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome! You have registered successfully."
      redirect_to home_path
    else
      flash[:error] = "Please fix the following errors."
      render :new
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :password, :full_name)
    end
end