class PostsController < ApplicationController
  before_action :find_post, only: [:show, :thumbsdown, :thumbsup]
  before_action :set_variables, only: [:show, :thumbsdown, :thumbsup]
  
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
    @post.profile_image_url = params[:post][:profile_image_url]
    @post.text = params[:post][:text]
    @post.net_thumbs = 0
    @post.tweet_url = params[:post][:tweet_url]
    @post.like_in_twitter = params[:post][:like_in_twitter]
    @post.twitter_username = params[:post][:username]
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
    tw = Tweet.new
    @tweet_info = tw.get_tweet_info(@post.tweet_id)
    @post.like_in_twitter = @tweet_info.favorite_count
    @post.net_thumbs = @post.thumbsup - @post.thumbsdown
    @post.total_net_like = @post.like_in_twitter + @post.thumbsup - @post.thumbsdown
    @post.save
  end

  def random
    @post = Post.where( 'id >= ?', rand(Post.first.id..Post.last.id) ).first
    redirect_to @post
  end

  def thumbsdown
    # binding.pry
    @post.addthumbsdown
  end
  
  def thumbsup
    # binding.pry
    @post.addthumbsup
  end
  
  def worst
    @posts_worst = Post.limit(100).order(net_thumbs: :asc)
  end
  
  def best
    @posts_best = Post.limit(100).order(net_thumbs: :desc)
  end
  
  def set_variables
    @id_thumbsup = "#thumbsup-link-#{@post.id}"
    @id_thumbsdown = "#thumbsdown-link-#{@post.id}"
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
