module PostsHelper
    require 'bitly'
    require 'dotenv'

    def get_share_url(page_url)
        # binding.pry
        client = Bitly::API::Client.new(token: ENV["BITLY_ACCESS_TOKEN"])

        # binding.pry
        bitlink = client.shorten(long_url: page_url)
        bitlink.link
    end 
end
