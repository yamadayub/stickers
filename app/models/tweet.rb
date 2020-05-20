class Tweet
  # MixInでTableなしでもModelとして扱える様にする
  include ActiveModel::Model
  
  # プロパティの設定
  attr_accessor :user_screen_name, :tweet_id,  :text, :profile_image_url, :favorite_count, :tweet_url

  def search_tweet(keyword)
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = Settings.twitter_api.consumer_key
      config.consumer_secret      = Settings.twitter_api.consumer_secret
    end
    @tweet_texts = []
    @word = keyword
    since_id = nil
    # 検索ワードが存在していたらツイートを取得
    if keyword.present?
      # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
      @tweet_results = client.search(keyword, count: 50, result_type: "recent", exclude: "retweets", since_id: since_id)

      # 取得したツイートをモデルに渡す
      @tweet_results.take(50).each do |tw|
        @tweet_texts << "#{tw.full_text.to_s}, URI:#{tw.uri.to_s}, LIKE:#{tw.favorite_count}, ID:#{tw.id}, Source:#{tw.source}"
      end

      # binding.pry
      @tweets = []
      @tweet_results.attrs[:statuses].each do |tweet|
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
  end
  
  def search_timeline(username)
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = Settings.twitter_api.consumer_key
      config.consumer_secret      = Settings.twitter_api.consumer_secret
    end
    timeline = client.user_timeline(username, { count: 50, include_rts: false, exclude_replies: true })
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
    timeline = client2.user_timeline(username, options = { max_id: last_tweet_id, count: 21, include_rts: false, exclude_replies: true  })
    #binding.pry    
    
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
end