require 'aws-sdk'

class FileController < ApplicationController

    def get_file
        puts "_________________________________-"
        puts "FILE BODY"
        puts params[:file].tempfile
        puts params[:filename]
        puts params[:roomname]
        @room = Room.find_by(name: params[:roomname])
        puts @room
        puts "_________________________________"
        creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
        s3 = Aws::S3::Resource.new(region: 'us-east-2', credentials: creds)
        obj = s3.bucket('16arqsisv2-css').object(params[:filename])
        obj.upload_file(params[:file].tempfile)

        @room.style_sheet = "https://16arqsisv2-css.s3.amazonaws.com/#{params[:filename]}"
        @room.save
        render json: {"success": "true"}
    end
end
