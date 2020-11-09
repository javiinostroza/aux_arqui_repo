class RequestsController < ApplicationController


    def accept
        puts "_________________________________-"
        puts "Request accepted"
        puts params[:url]
        @request = Request.find_by(url: params[:url])
        @room = @request.find_by(room_id: @requests.room_id)
        puts @room
        puts "_________________________________"
        @room.style_sheet = @requests.url
        @room.save
        render json: {"success": "true"}
    end

    def show
        @requests = Request.all        
        render json: @requests
    end
end
