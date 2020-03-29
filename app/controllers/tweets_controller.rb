class TweetsController < ApplicationController
  def search
    client = Twitter::REST::Client.new do |config|
      # 事前準備で取得したキーのセット
      config.consumer_key         = Settings.twitter_api.consumer_key
      config.consumer_secret      = Settings.twitter_api.consumer_secret
    end
    @tweet_texts = []
    @word = params[:keyword]
    since_id = nil
    # 検索ワードが存在していたらツイートを取得
    if params[:keyword].present?
      # リツイートを除く、検索ワードにひっかかった最新10件のツイートを取得する
      @tweet_results = client.search(params[:keyword], count: 10, result_type: "recent", exclude: "retweets", since_id: since_id)
      # 取得したツイートをモデルに渡す
      @tweet_results.take(10).each do |tw|
        @tweet_texts << "#{tw.full_text.to_s}, URI:#{tw.uri.to_s}, LIKE:#{tw.favorite_count}, ID:#{tw.id}, Source:#{tw.source}"
      end
      
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
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tweets } # jsonを指定した場合、jsonフォーマットで返す
    end
    
    # @posts = Array.new()
    # 10.times do |i|
    #   @posts[i] = Post.new()
    # end
    
    # binding.pry
    render 'tweets/search'
  end
  
  def index
  end
end
