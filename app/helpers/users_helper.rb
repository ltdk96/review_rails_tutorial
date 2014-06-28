module UsersHelper
  
  def gravatar_for user, options = {}
	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	size = (80 || options[:size])

	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{size}"
	image_tag(gravatar_url, alt: user.name)
  end

  def right_password?(user, password)  	
  	user.authenticate(password)
  end

end
