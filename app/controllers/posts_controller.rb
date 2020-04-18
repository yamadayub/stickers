class PostsController < ApplicationController
  before_action :find_post, only: [:show, :thumbsdown, :thumbsup]
  
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
    # binding.pry
    @post = Post.new
    @post.tweet_id = params[:post][:tweet_id]
    @post.sns_post_url = params[:post][:sns_post_url]
    @post.thumbsdown = 0
    @post.thumbsup = 0
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
    # @dislike_coount = Dislike.count_dislikes(@post)
    #binding.pry
    #このTweetを引っ張ってきてfavorite_countを取る
    #Tweetモデルに実装する方がすっきりする
    
    #該当Tweetの情報を改めて持ってくる
    
  end
  
  def thumbsdown
    # binding.pry
    if @post.addthumbsdown
      #flash[:success] = "Updateに成功しました"
      #binding.pry
      redirect_back(fallback_location: root_path)
    else
      #flash[:danger] = "Updateに失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def thumbsup
    # binding.pry
    if @post.addthumbsup
      #flash[:success] = "Updateに成功しました"
      #binding.pry
      redirect_back(fallback_location: root_path)
    else
      #flash[:danger] = "Updateに失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def find_post
    # binding.pry
    @post = Post.find(params[:id])
  end
  
  private
  def post_params
    # binding.pry
    params.require(:post).permit(:post_id)
  end
end
