class PostsController < ApplicationController
  #tweetの検索画面を表示する
  def index
    @post = Post.new()
  end
  
  #twitterからtweet情報を持ってくる
  def search
    sns_post_url = params[:sns_post_url]
    
  end

  #postのレコードを作る
  def create
  end

  #post情報を表示する
  def show
  end
end
