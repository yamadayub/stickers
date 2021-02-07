namespace :create_post do
  desc "Postの作成"
  task :task_post_creation => :environment do
    
    puts "Task started"
    
    #Twitter connection > Tweet Model
    #Tweet search
    tw = Tweet.new
    trend_tweet = tw.get_a_trend_tweet

    #Post data
    @post = Post.new()
    @post.tweet_id = trend_tweet.tweet_id
    @post.sns_post_url = trend_tweet.tweet_url
    @post.thumbsdown = rand(1..20)
    @post.thumbsup = rand(1..1000)
    @post.profile_image_url = trend_tweet.profile_image_url
    @post.text = trend_tweet.text
    @post.tweet_url = trend_tweet.tweet_url
    @post.like_in_twitter = trend_tweet.favorite_count
    @post.twitter_username = trend_tweet.user_screen_name
    @post.net_thumbs = trend_tweet.favorite_count + @post.thumbsup - @post.thumbsdown 
    
    # @post.tweet_id = 1
    # @post.sns_post_url = "http://www.sample.com"
    # @post.thumbsdown = rand(1..20)
    # @post.thumbsup = rand(1..1000)
    # @post.profile_image_url = "http://www.sample.com"
    # @post.text = "A text for test"
    # @post.tweet_url = "http://www.sample.com"
    # @post.like_in_twitter = rand(1..10000)
    # @post.twitter_username = "test account"
   
    #Post save 
    if @post.save
      puts "A Post created."
    else
      puts "A Post is not created."
    end
    
  end
end

