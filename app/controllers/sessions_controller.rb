class SessionsController < ApplicationController
  before_action :not_signed_in, only: [:new, :create]

  def new  	
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  	  sign_in user
  	  redirect_to user_path(user)	
  	else
  	  flash.now[:error]	= 'Invalid username or password!'
  	  render :new
  	end
  end

  def destroy
  	sign_out
	redirect_to signin_path
  end

end
