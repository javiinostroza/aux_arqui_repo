class Cognito
    @client = Aws::CognitoIdentityProvider::Client.new
  
    def self.authenticate(user_object)
      auth_object = {
        user_pool_id: ENV['AWS_COGNITO_POOL_ID'],
        client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
        auth_flow: 'ADMIN_NO_SRP_AUTH',
        auth_parameters: user_object
      }
  
      @client.admin_initiate_auth(auth_object)
    end
  
    def self.sign_out(access_token)
      @client.global_sign_out(access_token: access_token)
    end
    
    def self.create_user(user_object)
      auth_object = {
        client_id: ENV['AWS_COGNITO_APP_CLIENT_ID'],
        username: user_object[:USERNAME],
        password: user_object[:PASSWORD]
      }
  
      @client.sign_up(auth_object)
    end
  end