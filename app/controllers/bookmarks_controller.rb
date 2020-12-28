class BookmarksController < ApplicationController
  def index
    mybookmarks = Bookmark.where(user_id: current_user.id)
    @posts = []
    # binding.pry
    mybookmarks.each do |bm|
      @posts << Post.find_by(id: bm.post_id)
    end
  end

  def create
    @bookmark = Bookmark.new
    @bookmark.post_id = params[:bookmark][:post_id]
    @bookmark.user_id = params[:bookmark][:user_id]
  
    @post = Post.find(@bookmark.post_id)
    #binding.pry
    
    if @bookmark.save
      flash[:success] = "Bookmarkに成功しました"
      #binding.pry
      redirect_back fallback_location: @post
    else
      flash[:danger] = "Bookmarkに失敗しました"
      redirect_back fallback_location: @post
    end
    
  end

  def destroy
    binding.pry
    @bookmark = Bookmark.find_by(id: params[:id])
    @post = Post.find_by(id: @bookmark.post_id)

    if @bookmark.user_id == current_user.id
      if @bookmark.destroy
        flash[:success] = "Bookmarkの削除に成功しました"
        #binding.pry
        redirect_back fallback_location: @post
      else
        flash[:danger] = "Bookmarkの削除に失敗しました"
        redirect_back fallback_location: @post
      end
    end
  end
end
