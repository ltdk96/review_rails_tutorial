class UsersController < ApplicationController

  include UsersHelper
  
  before_action :signed_in, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_only, only: [:destroy]
  before_action :not_signed_in, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

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
    @tweets = @user.feed.paginate(page: params[:page], per_page: 10)
  end

  def edit
    #@user already defined in filters
  end

  def update
    #@user already defined in filters

    if right_password?(@user, params[:user][:current_password])
      if @user.update_attributes(user_params)
        flash[:success] = 'Settings updated!'
        redirect_to edit_user_path(@user)
      else
        render :edit
      end
    else
      flash[:error] = "Are you hacking?"
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted!'
    redirect_to users_path
  end

  private
    def user_params      
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def correct_user
      @user = User.find(params[:id])
      unless current_user? @user
        flash[:error] = "You can't do it!"
        redirect_to root_path
      end
    end

    def admin_only
      to_delete = User.find(params[:id])
      if !current_user.admin || current_user?(to_delete)        
        redirect_to root_path
      end
    end

end
