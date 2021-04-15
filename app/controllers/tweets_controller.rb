class TweetsController < InheritedResources::Base
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :set_reetweet, only: %i[ repost friendship unfriendship ]


  def index
    @tweets = Tweet.all.order("created_at DESC")
    @tweet = Tweet.new
  end

  def show
  end

  def new
    @tweet = current_user.tweets.build
  end

  def edit
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: 'Tweet was successfully created.' }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def retweet
    if current_user
      @tweet = Tweet.find(params[:tweet_id])
      Tweet.create(content: @tweet.content, user_id: current_user.id)
    else
      redirect_to new_session_path
    end
      redirect_to root_path
  end

  def friendship
    Friendship.create(user_id: current_user.id, friend_id: @tweet.user_id)
    redirect_to root_path
  end

  def unfriendship
  @friendship = Friendship.find_by(friend_id: @tweet.user.id)
  @friendship.destroy
  redirect_to root_path
  end

  private
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def set_reetweet
      @tweet = Tweet.find(params[:tweet_id])
    end

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end

