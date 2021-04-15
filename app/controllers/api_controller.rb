class ApiController < ApplicationController
    protect_from_forgery with: :null_session

    include ActionController::HttpAuthentication::Basic::ControllerMethods

    http_basic_authenticate_with name: "desafio", password: "latam"

    def news
      new_array = []
      Tweet.all.each do |tweet|
      new_array << {:id => tweet.id, :content => tweet.content, :user_id => tweet.user_id, :likes_count => tweet.likes.count, :retweets_count => tweet.retweet.count, :retwitted_from => tweet.retweet_id} 
      end
      @tweets = new_array
      render json: @tweets.last(50)
    end

    
    def create
        @tweet = Tweet.new(tweet_params)
    
        if @tweet.save
            render json: @tweet, location: @tweet
        else
            render json: @tweet.errors
        end
    end


    private
    def tweet_params
        params.require(:tweet).permit(:content, :user_id)
    end
end
