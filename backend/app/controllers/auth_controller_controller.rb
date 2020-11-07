class AuthControllerController < ApplicationController
    def sign_in
      user_object = {
        USERNAME: params[:username],
        PASSWORD: params[:password]
      }
      begin
        resp = Cognito.authenticate(user_object).authentication_result
      rescue => e
        resp = e
      end
      render json: resp
    end
    
    def sign_out
      if request.headers['Authorization']
        Cognito.sign_out(request.headers['Authorization'])
        resp = { type: 'success', message: 'now you are disconected' }
      else
        resp = { type: 'error', message: 'empty token' }
      end
      render json: resp
    end
end
