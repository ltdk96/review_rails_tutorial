module UsersHelper
  
  def gravatar_for user, options = {}
	gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
	size = (options[:size] || 80)
	gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{size}"

	style = (options[:style] || 'gravatar')
	image_tag(gravatar_url, alt: user.name, class: style)
  end

  def right_password?(user, password)  	
  	user.authenticate(password)
  end

end
