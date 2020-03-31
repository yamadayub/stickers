class Dislike < ApplicationRecord
  belongs_to :post
  belongs_to :user
  
  def count_dislikes(post)
    Dislike.where(post_id: post.id).size
  end
end
