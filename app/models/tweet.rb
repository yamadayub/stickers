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
      @tweet_results = client.search(keyword, count: 20, result_type: "recent", exclude: "retweets", since_id: since_id)

      # 取得したツイートをモデルに渡す
      @tweet_results.take(20).each do |tw|
        @tweet_texts << "#{tw.full_text.to_s}, URI:#{tw.uri.to_s}, LIKE:#{tw.favorite_count}, ID:#{tw.id}, Source:#{tw.source}"
      end

      # binding.pry
      @tweets = []
      @tweet_results.attrs[:statuses].each do |tweet|
        @tweet = Tweet.new
        @tweet.user_screen_name = tweet[:user][:screen_name]
        @tweet.tweet_id = tweet[:id]
        @tweet.text = tweet[:text]
        @tweet.profile_image_url = tweet[:user][:profile_image_url]
        @tweet.favorite_count = tweet[:favorite_count]
        @tweet.tweet_url = "https://twitter.com/#{tweet[:user][:screen_name]}/status/#{tweet[:id]}"
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
    timeline = client.user_timeline(username)
    @tweets = []
    # binding.pry
    timeline.each do |tweet|
      # binding.pry
      @tweet = Tweet.new
      @tweet.user_screen_name = tweet[:user][:screen_name]
      @tweet.tweet_id = tweet[:id]
      @tweet.text = tweet[:text]
      @tweet.profile_image_url = tweet[:user][:profile_image_url]
      @tweet.favorite_count = tweet[:favorite_count]
      @tweet.tweet_url = "https://twitter.com/#{tweet[:user][:screen_name]}/status/#{tweet[:id]}"
      @tweets << @tweet
    end
    @tweets
  end
end