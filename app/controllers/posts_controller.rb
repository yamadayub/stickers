class PostsController < ApplicationController
  #tweetの検索画面を表示する
  def index
    @post = Post.new()
  end
  
  #twitterからtweet情報を持ってくる
  def search
    @tweets ||= []
    tweet_search(params[:keyword])    
  end

  #postのレコードを作る
  def create
  end

  #post情報を表示する
  def show
  end

end
