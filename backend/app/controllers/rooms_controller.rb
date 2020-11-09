class RoomsController < ApplicationController
  skip_before_action :authorized
  # Loads:
  # @rooms = all rooms
  # @room = current room when applicable
  before_action :load_entities
  
  def destroy
    @rooms = Room.all
    @room = Room.find(params[:id]) if params[:id]
    @room.destroy
  end

  def index
    @rooms = Room.all
    json = Rails.cache.fetch(Room.cache_key(@rooms)) do 
      @rooms
    end
    render json: json
  end

  def new
    @room = Room.new
  end

  def create
    room_name = params[:name]
    if Room.find_by name: room_name
      return render json: {
        "error": "Another room already has that name"
      }
    else
      params = ActionController::Parameters.new({
        room: {
          name: room_name
        }
      })
      @room = Room.new permitted_parameters
      if @room.save
        render json: @room
      else
        return render json: {
          "error": "error creating room."
        }
      end
    end
  end

  def edit
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Room #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def show
    room = Room.find_by(id: params[:id])
    if room
      messages = RoomMessage.joins(:room).joins(:user).where(room_id: params[:id]).select('room_messages.*, users.username, users.thumbnail_url')
      # render json: {
      #   "room": room,
      #   "messages": messages
      # }
      json = Rails.cache.fetch('messages') do
        {
          "room": room,
          "messages": messages
        }
      end
    else
      return render json: {
        "error": "room not found"
      }
    end
    render json: json
  end

  def getroommessagespdf
    room = Room.find_by(id: params[:room_id])
    if room
      data = {
        "room": room,
        "messages": room.room_messages.map {
           |msg| {
              "message": msg.message,
              "created_at": msg.created_at,
              "author": msg.user.username
              }
          }
      }
      url_pdf = get_pdf_url(data)
      return render json: {
        "url_pdf": url_pdf
      }
    else
      return render json: {
        "error": "#noroom"
      }
    end
  end

  def get_pdf_url(data)
    form_data = {"data": data}
    form_data = form_data.to_json

    response = HTTParty.post("https://9x3j0lz3cc.execute-api.us-east-1.amazonaws.com/dev/api/htmltopdf", {
      body: form_data,
      headers: {
        'Content-Type' => 'application/json',
        'x-api-key': ENV["AWS_API_HTMLTOPDF_KEY_ID"]
      }
    })
    response_body = JSON.parse(response.body)
    return response_body["url_pdf"]
  end


  protected

  def load_entities
    @rooms = Room.all
    @room = Room.find(params[:id]) if params[:id]
  end

  

  def permitted_parameters
    params.permit(:name)
  end
end
