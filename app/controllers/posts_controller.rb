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
    @post = Post.new
    @post.tweet_id = params[:tweet_id]
    @post.sns_post_url = params[:tweet_url]
    #binding.pry
    
    if @post.save
      flash[:success] = "投稿に成功しました"
      #binding.pry
      redirect_to @post
    else
      flash[:danger] = "投稿に失敗しました"
      redirect_to :back
    end
  end

  #post情報を表示する
  def show
    @post = Post.find(params[:id])
    @dislike = Dislike.new
    #binding.pry
    
    #このTweetを引っ張ってきてfavorite_countを取る
    #Tweetモデルに実装する方がすっきりする
    
  end
end
