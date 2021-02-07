class Tweet
  # MixInでTableなしでもModelとして扱える様にする
  include ActiveModel::Model
  
  # プロパティの設定
  attr_accessor :user_screen_name, :tweet_id,  :text, :profile_image_url, :favorite_count, :tweet_url

  def search_timeline(username)
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = Settings.twitter_api.consumer_key
      config.consumer_secret      = Settings.twitter_api.consumer_secret
    end
    timeline = client.user_timeline(username, { count: 50, include_rts: false, exclude_replies: false })
    @username = username
    @tweets = []
    # binding.pry
    timeline.each do |tweet|
      # binding.pry
      @tweet = Tweet.new
      @tweet.user_screen_name = tweet.user.screen_name
      @tweet.tweet_id = tweet.id
      @tweet.text = tweet.text
      @tweet.profile_image_url = tweet.user.profile_image_url
      @tweet.favorite_count = tweet.favorite_count
      @tweet.tweet_url = "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
      @tweets << @tweet
    end
    @tweets
  end
  
  def add_tweets_for_timeline(username, last_tweet_id)
    client2 = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = Settings.twitter_api.consumer_key
      config.consumer_secret      = Settings.twitter_api.consumer_secret
    end
    #binding.pry
    
    #tweet_count以降のtweetsを取得
    timeline = client2.user_timeline(username, options = { max_id: last_tweet_id, count: 21, include_rts: false, exclude_replies: false })
    binding.pry    
    
    @username = username
    @add_tweets = []
    
    timeline[1..20].each do |tweet|
      #binding.pry
      @tweet = Tweet.new
      @tweet.user_screen_name = tweet.user.screen_name
      @tweet.tweet_id = tweet.id
      @tweet.text = tweet.text
      @tweet.profile_image_url = tweet.user.profile_image_url
      @tweet.favorite_count = tweet.favorite_count
      @tweet.tweet_url = "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
      @add_tweets << @tweet
    end
    @add_tweets
  end

  def add_tweets_for_mytimeline(last_tweet_id)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_API_KEY']
      config.consumer_secret = ENV['TWITTER_API_SECRET']
      config.access_token    = session[:oauth_token]
      config.access_token_secret = session[:oauth_token_secret]
    end
    #binding.pry
    
    #max_id以降のtweetsを取得
    timeline = @client.home_timeline(options = { max_id: last_tweet_id, count: 21, include_rts: false, exclude_replies: false })
    binding.pry    
    
    @add_tweets = []
    
    timeline[1..20].each do |tweet|
      #binding.pry
      @tweet = Tweet.new
      @tweet.user_screen_name = tweet.user.screen_name
      @tweet.tweet_id = tweet.id
      @tweet.text = tweet.text
      @tweet.profile_image_url = tweet.user.profile_image_url
      @tweet.favorite_count = tweet.favorite_count
      @tweet.tweet_url = "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
      @add_tweets << @tweet
    end
    @add_tweets
  end
  
  def get_tweet_info(tweet_id)
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = Settings.twitter_api.consumer_key
      config.consumer_secret      = Settings.twitter_api.consumer_secret
    end
    #@tweet_info = client.search(max_id: tweet_id, count: 1)
    client.status(tweet_id)
    # binding.pry
  end
  
  def get_a_trend_tweet #Trend Tweetの中から１件を返す
      client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = Settings.twitter_api.consumer_key
      config.consumer_secret      = Settings.twitter_api.consumer_secret
    end
    
    #get trend tweets
    trends = client.trends
    
    #このトレンドサーチkeywordでTimelineを再サーチしてtop hit tweetをPost作成
    query = trends.first.to_hash[:query]
    tweet = client.search(query,options = { esult_type: "recent", include_rts: false, exclude_replies: false} ).first

    @trend_tweet = Tweet.new
    @trend_tweet.user_screen_name = tweet.user.screen_name
    @trend_tweet.tweet_id = tweet.id
    @trend_tweet.text = tweet.text
    @trend_tweet.profile_image_url = tweet.user.profile_image_url.to_s
    @trend_tweet.favorite_count = tweet.retweeted_status.favorite_count
    @trend_tweet.tweet_url = "https://twitter.com/#{tweet.user.screen_name}/status/#{tweet.id}"
    return @trend_tweet
  end
end