class TweetsController < ApplicationController
  def search
  end
  
  def timeline
    tw = Tweet.new
    # binding.pry
    @username = params[:search_username].gsub(" ", "").gsub("　", "")
    @timeline = tw.search_timeline(@username)
    @last_tweet_id = @timeline.last.tweet_id
    render 'tweets/timeline'
  end
  
  def mytimeline #このmethodに来る前にログインとTwitter IDがあることを確認

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_API_KEY']
      config.consumer_secret = ENV['TWITTER_API_SECRET']
      # binding.pry
      config.access_token    = session[:oauth_token]
      config.access_token_secret = session[:oauth_token_secret]
    end
    # 特定ユーザのtimeline取得
    @mytimeline = @client.home_timeline( { count: 20 })
    @last_tweet_id = @mytimeline.last.id
    # binding.pry
    render 'tweets/mytimeline'
    
  end
  
  def search_tweet
    tw = Tweet.new
    tw.search_tweet()
  end
  
  def timeline_reload
    tw = Tweet.new
    #binding.pry
    @username = params[:username].gsub(" ", "").gsub("　", "")
    @last_tweet_id = params[:last_tweet_id]
    @add_tweets = tw.add_tweets_for_timeline(@username, @last_tweet_id)    
    @last_tweet_id = @add_tweets.last.tweet_id
    #binding.pry
  end
  
  def mytimeline_reload
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_API_KEY']
      config.consumer_secret = ENV['TWITTER_API_SECRET']
      config.access_token    = session[:oauth_token]
      config.access_token_secret = session[:oauth_token_secret]
    end
    # binding.pry
    # tw = Tweet.new
    # @mytimeline_add = tw.add_tweets_for_mytimeline(@last_tweet_id)
    # @last_tweet_id = @mytimeline_add.last.tweet_id    

    @last_tweet_id = params[:last_tweet_id]
    @mytimeline_add = @client.home_timeline(options = { max_id: @last_tweet_id })
    @last_tweet_id = @mytimeline_add.last.id
  end
  
  def index
  end
end
