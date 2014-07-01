class RelationshipsController < ApplicationController
  
  before_action :signed_in

  def create
  	@follow = User.find(params[:relationship][:followed_id])
  	current_user.follow!(@follow)

  	redirect_to user_path(@follow)
  end

  def destroy
  	@unfollow = Relationship.find(params[:id]).followed
  	current_user.unfollow!(@unfollow)

  	redirect_to user_path(@unfollow)
  end

end
