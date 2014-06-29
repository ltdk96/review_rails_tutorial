class User < ActiveRecord::Base

  #callbacks
  before_create :create_remember_token
  before_save { email.downcase! }

  #validations (name, email & password)
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

  #associations
  has_many :tweets, dependent: :destroy
  
  #remember tokens
  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.digest token
  	Digest::SHA1.hexdigest(token.to_s)
  end

  #Tweets feed
  def feed
    Tweet.where('user_id = ?', self.id)
  end

  private
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)	
    end

end
