class Post < ApplicationRecord
  has_many :dislikes
  
  def addthumbsdown
    # binding.pry
    self.thumbsdown += 1
    self.net_thumbs -= 1
    self.update(thumbsdown: self.thumbsdown, net_thumbs: self.net_thumbs)
  end
  
  def addthumbsup
    # binding.pry
    self.thumbsup += 1
    self.net_thumbs +=1
    self.update(thumbsup: self.thumbsup, net_thumbs: self.net_thumbs)
  end
end
