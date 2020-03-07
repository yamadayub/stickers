class Tweet
  # MixInでTableなしでもModelとして扱える様にする
  include ActiveModel::Model

  # プロパティの設定
  attr_accessor :contents

  def initialize(contents)
    @contents = contents
  end
end