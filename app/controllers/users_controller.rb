class UsersController < ApplicationController
  
  before_action :not_signed_in, only: [:new, :create]

  def new
  	@user = User.new            
  end

  def create
  	@user = User.new(user_params)

    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Twister!"
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
    def user_params      
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
