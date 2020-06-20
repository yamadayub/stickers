class Post < ApplicationRecord
  has_many :dislikes
  
  def addthumbsdown
    # binding.pry
    self.thumbsdown += 1
    self.net_thumbs -= 1
    self.total_net_like -= 1
    self.update(thumbsdown: self.thumbsdown, net_thumbs: self.net_thumbs, total_net_like: self.total_net_like)
  end
  
  def addthumbsup
    # binding.pry
    self.thumbsup += 1
    self.net_thumbs +=1
    self.total_net_like +=1
    self.update(thumbsup: self.thumbsup, net_thumbs: self.net_thumbs, total_net_like: self.total_net_like)
  end
end
