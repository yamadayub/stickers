namespace :tweet_post do
  require 'bitly'
  desc ""
  task :task_tweet_creation => :environment do
    
    puts "Task started"
    
    #Twitter Connection
    client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token    = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
    
    #Post data
        
    until @post
      @post = Post.where( 'id >= ?', rand(Post.first.id..Post.last.id) ).first
    end
    
    def get_share_url(page_url)
        # binding.pry
        client = Bitly::API::Client.new(token: ENV["BITLY_ACCESS_TOKEN"])

        # binding.pry
        bitlink = client.shorten(long_url: page_url)
        bitlink.link
    end 
  
    #Twitter Post
    post_url = "https://www.thumbsmore.com/posts#{@post.id}"
    text = "Thumbs-up or down? | #{@post.twitter_username} | #{@post.text.slice(0..180)} | #{get_share_url(post_url)} | #thumbsmore"
   
    client.update(text)

  end
end
