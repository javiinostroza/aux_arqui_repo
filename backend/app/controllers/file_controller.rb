require 'aws-sdk'

class FileController < ApplicationController

    def post_file
        puts "_________________________________-"
        puts "FILE BODY"
        puts params[:file].tempfile
        puts params[:filename]
        puts params[:roomname]
        puts "_________________________________"
        creds = Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
        s3 = Aws::S3::Resource.new(region: 'us-east-2', credentials: creds)
        obj = s3.bucket('16arqsisv2-css').object(params[:filename])
        obj.upload_file(params[:file].tempfile)

        parameters = ActionController::Parameters.new({
            request: {
                url: "",
                room_id: "",
                accepted: false
            }
        })
        parameters[:request][:url] = "https://16arqsisv2-css.s3.amazonaws.com/#{params[:filename]}"
        parameters[:request][:room_id] = params[:roomname]
        @request = Request.create(parameters.require(:request).permit(:url, :room_id, :accepted))
        render json: @request 
        end
end
