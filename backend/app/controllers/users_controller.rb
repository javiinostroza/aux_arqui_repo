require 'uri'
require 'net/http'

class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :set_email, :uploadphoto]

  def new
    if logged_in?
      redirect_to '/rooms'
    end
    @user = User.new
  end

  def create
    parameters = ActionController::Parameters.new({
      user: {
        username: "",
        password: "password",
        email: "",
        is_admin: false
      }
    })
    if params[:anon] == "true"
      parameters[:user][:username] = "anon" + SecureRandom.hex(15)
    else
      parameters[:user][:username] = params[:username]
    end
    @params = JSON.parse(request.body.read)
    parameters[:user][:username] = @params['username']
    parameters[:user][:password] = @params['password']
    parameters[:user][:email] = @params['email']
    @user = User.create(parameters.require(:user).permit(:username, :password, :email, :is_admin))
    self.create_auth0_user(@user)
    render json: @user 
  end

  def set_email
    user = User.find_by(id: params[:id])
    if user
      user.update_attributes(:email => params[:email])
      return render json: user
    else
      return render json: {
        "error": "user not found"
      }
    end
  end
  
  def uploadphoto()
    @user = User.find_by(username: params[:username])
    #@user.photo.purge
    #@user.photo.attach(params[:photo])
    extension = params[:photo].content_type.split('/')[1]
    filename = "#{SecureRandom.hex(15)}.#{extension}"
    
    s3 = Aws::S3::Resource.new(region:'us-west-2')
    obj = s3.bucket('chatroom-profileimg-upload').object(filename)
    obj.upload_file(params[:photo].tempfile)

    source = "https://chatroom-profileimg-resized.s3-us-west-2.amazonaws.com/"
    url_photo = "#{source}#{filename}"
    @user.thumbnail_url = url_photo
    @user.save
    render json: @user
  end

  def create_auth0_user(user)
    url = URI("https://dev-3qxptrmu.us.auth0.com/dbconnections/signup")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request.body = "{\"client_id\":\"#{Rails.application.secrets.client_id}\",\"client_secret\":\"#{Rails.application.secrets.client_secret}\",\"email\":\"#{user.email}\",\"password\":\"#{user.password}\",\"connection\":\"Username-Password-Authentication\",\"user_metadata\":{ \"id\": \"#{user.id}\"}}"

    response = http.request(request)
    puts "---------------------------------------------------"
    puts response.read_body
    puts "---------------------------------------------------"
  end
end
