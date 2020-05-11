class TweetsController < ApplicationController
  def search
    tw = Tweet.new
    @tws = tw.search_tweet(params[:keyword])
    render 'tweets/search'
  end
  
  def timeline
    tw = Tweet.new
    @username = params[:search_username]
    @timeline = tw.search_timeline(params[:search_username])
    @last_tweet_id = @timeline.last.tweet_id
    #binding.pry
    render 'tweets/timeline'
  end
  
  def search_tweet
    tw = Tweet.new
    tw.search_tweet()
  end
  
  def timeline_reload
    tw = Tweet.new
    #binding.pry
    @username = params[:username]
    @last_tweet_id = params[:last_tweet_id]
    @add_tweets = tw.add_tweets_for_timeline(@username, @last_tweet_id)    
    @last_tweet_id = @add_tweets.last.tweet_id
    #binding.pry
  end
  
  def index
  end
end
