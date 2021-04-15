class LikesController < ApplicationController
    before_action :set_tweet
    before_action :find_like

  def create
    if already_liked?
        flash[:notice] = "You can't like more than once"
    else
    @tweet.likes.create(user_id: current_user.id)
    redirect_to root_path
  end

  def find_like
    @like = @tweet.likes.find(params[:id])
 end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to root_path
  end

  private
  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def find_like
    @tweet = Tweet.find(params[:tweet_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, tweet_id:
    params[:tweet_id]).exists?
  end

end
