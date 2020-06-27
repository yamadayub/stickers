require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Boo
  class Application < Rails::Application
    before_action :detect_locale
    
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # unless Rails.env.production?
    #   config.web_console.whitelisted_ips = '124.209.183.109'
    # end
    
    config.i18n.default_locale = :en
    
    private 
      def detect_locale
        I18n.locale = request.headers['Accept-Language'].scan(/¥A[a-z]{2}/).first
      end
  end
end
