class TweetsController < ApplicationController
  def search
    tw = Tweet.new
    @tws = tw.search_tweet(params[:keyword])
    render 'tweets/search'
  end
  
  def timeline
    tw = Tweet.new
    @timeline = tw.search_timeline(params[:search_username])
    # binding.pry
    render 'tweets/timeline'
  end
  
  def search_tweet
    tw = Tweet.new
    tw.search_tweet()
  end
  
  def index
  end
end
