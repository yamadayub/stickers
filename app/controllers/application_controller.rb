class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :detect_locale
    
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production? or Rails.env.staging?

  rescue_from ActionController::RoutingError, with: :url_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from Twitter::Error::NotFound, with: :twitter_not_found
  
  # rescue_from Twitter::Error::Unauthorized, with: :twitter_unauthorized

  private
  
    def detect_locale
      I18n.locale = request.headers['Accept-Language'].scan(/¥A[a-z]{2}/).first
    end

    def url_not_found(e)
      @exception = e
      render template: 'errors/url_not_found'
    end
    
    def record_not_found(e)
      @exception = e
      render template: 'errors/record_not_found'
    end
    
    def twitter_not_found(e)
      @exception = e
      render template: 'errors/not_found'
    end
    
    # def twitter_unauthorized
    #   @exception = e
    #   render template: 'error/not_found', status: 404
    # end
    
end

