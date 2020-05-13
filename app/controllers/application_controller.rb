class ApplicationController < ActionController::Base
  include SessionsHelper

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production? or Rails.env.staging?
end
