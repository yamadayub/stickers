class TweetsController < ApplicationController
  def search
    tw = Tweet.new
    @tws = tw.search_tweet(params[:keyword])
    render 'tweets/search'
  end
  
  def timeline
    tw = Tweet.new
    @timeline = tw.search_timeline(params[:keyword])
    # binding.pry
    render 'tweets/timeline'
  end
  
  def index
  end
end
