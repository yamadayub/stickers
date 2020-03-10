class Tweet
  # MixInでTableなしでもModelとして扱える様にする
  include ActiveModel::Model

  # プロパティの設定
  attr_accessor :user_screen_name, :tweet_id,  :text, :profile_image_url, :favorite_count, :tweet_url

end