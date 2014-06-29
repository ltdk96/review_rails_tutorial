class StaticPagesController < ApplicationController
  
  def home
  	if signed_in?
  	  @tweet = current_user.tweets.build
  	  @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
  	end
  end

  def help
  end

  def contact
  end

  def about
  end

end
