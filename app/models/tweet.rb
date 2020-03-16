class Tweet
  # MixInでTableなしでもModelとして扱える様にする
  include ActiveModel::Model
  
  # プロパティの設定
  attr_accessor :user_screen_name, :tweet_id,  :text, :profile_image_url, :favorite_count, :tweet_url

  def search_tweet
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = Settings.twitter_api.consumer_key
      config.consumer_secret      = Settings.twitter_api.consumer_secret
    end
    
    #一件のtweetを検索
    @tweet_results = client.search(params[:keyword], count: 10, result_type: "recent", exclude: "retweets", since_id: since_id)
    
  end
end