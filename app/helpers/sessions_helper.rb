module SessionsHelper

#---------------------------------------------------------------
  #signin/signout helpers
  def sign_in user
  	remember_token = User.new_remember_token
  	cookies.permanent[:remember_token] = remember_token
  	user.update_attribute(:remember_token, User.digest(remember_token))

  	self.current_user = user
  end

  def current_user=(user)
  	@current_user = user
  end

  def current_user
  	remember_token = User.digest(cookies[:remember_token])
  	@current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user? user
    current_user == user
  end

  def signed_in?
  	true unless current_user.nil?
  end

  def sign_out
  	current_user.update_attribute(:remember_token, User.digest(User.new_remember_token))
  	cookies.delete(:remember_token)

  	self.current_user = nil
  end

 #---------------------------------------------------------------
  #filters
  def not_signed_in
  	redirect_to root_path if signed_in?
  end

  def signed_in
    unless signed_in?
      store_location
      flash[:notice] = 'Please sign in!'
      redirect_to signin_path
    end
  end

#---------------------------------------------------------------
  #friendly-redirect helpers
  def store_location
    session[:previous_location] = request.url if request.get?
  end

  def redirect_back_or default
    redirect_to (session[:previous_location] || default)
    session.delete(:previous_location)
  end

#---------------------------------------------------------------
  #linh tinh helpers
  def delete_link path, options = {} 
    link_to 'delete', path, method: 'delete', data: { confirm: options[:message] }
  end

end