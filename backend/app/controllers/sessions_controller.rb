class SessionsController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
    if logged_in?
      redirect_to '/rooms'
    end
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user
      return render json: @user
    else
      return render json: {"error": "usuario no encontrado"}
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to '/welcome'
  end

  def login
  end

  def welcome
    if logged_in?
      redirect_to '/rooms'
    end
  end

end
