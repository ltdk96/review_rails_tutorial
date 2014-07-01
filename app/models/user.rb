class User < ActiveRecord::Base

  #callbacks
  before_create :create_remember_token
  before_save { email.downcase! }

#-----------------------------------------------------------------
  #VALIDATIONs: name, email & password
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, length: { minimum: 6 }

#-----------------------------------------------------------------
  #ASSOCIATIONs
  
  #tweets
  has_many :tweets, dependent: :destroy

  #has many followed_users
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followed_users, through: :following_relationships, source: :followed

  #has many followers
  has_many :be_followed_relationships, foreign_key: 'followed_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :be_followed_relationships, source: :follower

#-----------------------------------------------------------------
  #TOKENS-RELATED for LOGIN
  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  def User.digest token
  	Digest::SHA1.hexdigest(token.to_s)
  end

#-----------------------------------------------------------------
  #FOLLOW-RELATED METHODs
  def following? other_user
    self.following_relationships.find_by(followed_id: other_user.id)
  end

  def follow! other_user
    self.following_relationships.create!(followed_id: other_user.id)
  end

  def unfollow! other_user
    self.following_relationships.find_by(followed_id: other_user.id).destroy!
  end

#-----------------------------------------------------------------
  #THE TWEETS FEED
  #TODO: from you and your followed users
  def feed
    Tweet.from_users_followed_by(self)
  end

  private
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)	
    end

end
