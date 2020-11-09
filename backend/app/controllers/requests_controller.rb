class RequestsController < ApplicationController


    def accept
        puts "_________________________________-"
        puts "Request accepted"
        puts params[:id]
        @request = Request.find_by(id: params[:id])
        @room = Room.find_by(id: @request.room_id)
        puts @room
        puts "_________________________________"
        @room.style_sheet = @request.url
        @room.save
        @request.accepted = true
        @request.save
        render json: {"success": "true"}
    end

    def show
        @requests = Request.all        
        render json: @requests
    end
end
