# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

User.delete_all

user = User.create! email: 'sezuniga1@uc.cl',
            username: 'Samuel',
            password: 'Samuel12345',
            is_admin: true

#create_auth0_user(user)
user = User.create! email: 'juana@uc.cl',
            username: 'Juana',
            password: 'Juana2173',
            is_admin: true
#create_auth0_user(user)
user = User.create! email: 'hans@uc.cl',
            username: 'Hans',
            password: 'Hans2173',
            is_admin: true
#create_auth0_user(user)