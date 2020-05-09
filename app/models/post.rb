class Post < ApplicationRecord
  has_many :dislikes
  
  def addthumbsdown
    # binding.pry
    self.thumbsdown += 1
    self.update(thumbsdown: self.thumbsdown)
  end
  
  def addthumbsup
    # binding.pry
    self.thumbsup += 1
    self.update(thumbsup: self.thumbsup)
  end
end
