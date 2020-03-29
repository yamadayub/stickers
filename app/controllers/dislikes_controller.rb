class DislikesController < ApplicationController
  def create
    dislike = Dislike.new(dislike_params)
    
    if dislike.save
      flash[:success] = "dislikeしました!"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "dislikeできませんでした!!"
      render root_path
    end
  end

  def destroy
    dislike = Dislike.new(dislike_params)
    dislike.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def dislike_params
    params.require(:dislike).permit(:post_id, :user_id)
  end
end
