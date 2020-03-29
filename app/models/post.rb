class Post < ApplicationRecord
  has_many :dislikes
  
  def addthumbsdown
    # binding.pry
    # self.thumbsdown += 1
    self.update(thumbsdown: self.thumbsdown += 1)
  end
end
