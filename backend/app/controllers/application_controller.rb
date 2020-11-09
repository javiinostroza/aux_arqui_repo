class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  before_action :authorized
  helper_method :current_user
  helper_method :logged_in?
  after_action :custom_headers

  def custom_headers
    if Rails.env.production? 
      require 'net/http'
      url = URI.parse('http://169.254.169.254/latest/meta-data/instance-id')
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      response.headers['X-Fowarded-instance-id']=res.body
    end
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    #redirect_to '/welcome' unless logged_in?
  end

end
