class Tweet < ActiveRecord::Base
  
  belongs_to :user
  default_scope { order('created_at DESC') }

  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  #Query for the Feeds
  def Tweet.from_users_followed_by user
  	#sub-query for faster load
  	followed_user_ids = "SELECT followed_id FROM Relationships WHERE follower_id = :user_id"
  	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", user_id: user.id)
  end

end