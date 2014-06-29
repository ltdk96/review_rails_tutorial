class TweetsController < ApplicationController
  
  before_action :signed_in
  before_action :correct_user, only: [:destroy]

  def create
  	@tweet = current_user.tweets.build(tweet_params)

  	if @tweet.save
  	  flash[:success] = 'Tweet, tweet, more tweets!'
  	  redirect_to root_path
  	else
  	  @feed_items = current_user.feed.paginate(page: params[:page], per_page: 10)
  	  render 'static_pages/home'
  	end
  end

  def destroy
    @tweet.destroy
    flash[:success] = 'Tweets gone!'
    redirect_to root_path
  end

  private

  	def tweet_params
  	  params.require(:tweet).permit(:content)
  	end

    def correct_user
      @tweet = current_user.tweets.find_by(id: params[:id])
      redirect_to root_path if @tweet.nil?
    end

end
