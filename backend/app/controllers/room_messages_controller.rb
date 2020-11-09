class RoomMessagesController < ApplicationController
  #before_action :load_entities
  skip_before_action :authorized

  def destroy
    @room_mesages = RoomMessage.all
    @room_message = RoomMessage.find(params[:id]) if params[:id]
    @room_message.destroy
  end

  def create
    messagetxt = params.dig(:room_message, :message)
    new_message = ""
    if messagetxt == "/reset"
      @room.room_messages.destroy_all
      @room.reversed = false
      @room.save
      new_message = "Room has been reset"
    elsif messagetxt == "/reverse"
      @room.reversed = !@room.reversed
      @room.save
      new_message = "Messages have been reversed!"
    elsif messagetxt[0..9] == "/nameroom "
      messagetxt.slice!(0..9)
      messagetxt = messagetxt.strip
      new_message = "Error: New room name can't be blank!"
      if !messagetxt.nil? && !messagetxt.empty?
        new_name = messagetxt.strip
        @search = Room.find_by_name(new_name)
        if !@search.blank?
          new_message = "Error: Room name \'#{new_name}\' already exists"
        else 
          prev_name = @room.name 
          @room.name = new_name
          @room.save
          new_message = "Room name has changed: (#{prev_name}->#{@room.name}) succesfully"
        end
      end
    end
    if !new_message.nil? && !new_message.empty?
      if @room.reversed
        new_message = new_message.reverse
      end
      messagetxt = new_message
    end
    if !messagetxt.nil? && !messagetxt.empty?
      @room_message = RoomMessage.create user: current_user,
                                       room: @room,
                                       message: messagetxt
    end
    redirect_to room_path(@room)
  end

  def new_message
    if !params[:room_id] || !params[:user_id]
      return render json: {
        "error": "room_id or user_id parameters not detected"
    }
    end
    room = Room.find_by(id: params[:room_id])
    current_user = User.find_by(id: params[:user_id])

    if !room || !current_user
      return render json:{
        "error": "room or current user doesn't exist."
      }
    end
    received_message = params[:message]
    if is_username_mentioned(received_message)
      mention = get_username_mention(received_message)
      puts "---------------------------------"
      puts "mention:"
      puts mention
      user_mentioned = User.find_by(username: mention)
      if user_mentioned
        puts "user found."
        puts user_mentioned.username
        if user_mentioned.email
          puts "calling lambda function"
          send_email_mention(user_mentioned, room.name, received_message, user_mentioned.email)
        end
      else
        puts "user not found"
      end
    else
      puts "---------------"
      puts "no mention"
    end
    message = RoomMessage.create user: current_user, room: room, message: params[:message]
    room_messages = RoomMessage.joins(:room).joins(:user).where(room_id: params[:room_id]).select('room_messages.*, users.username')

    return render json: {
      "status": "message created",
      "room_messages": room_messages
    }
  end

  def is_username_mentioned(message)
    message_split = params[:message].split()
    message_split.each do |message|
      if message.start_with?("@")
        return true
      end
    end
    return false
  end
  
  # https://aws.amazon.com/premiumsupport/knowledge-center/lambda-send-email-ses/
  def send_email_mention(user, room_info, received_message, to_email)
    client = Aws::Lambda::Client.new(region: 'us-east-1')
    req_payload = {
      :email => user.email,
      :room_name => room_info,
      :received_message => received_message,
      :to_email => to_email
    }
    payload = JSON.generate(req_payload)
    puts "payload: "
    puts payload
    resp = client.invoke({
                          function_name: 'sendEmailFunction',
                        #  invocation_type: 'RequestResponse',
                          invocation_type: 'Event',
                         log_type: 'None',
                         payload: payload
                       })
    # resp_payload = JSON.parse(resp.payload.string)
    # puts resp_payload
  end

  def get_username_mention(message)
    message_split = params[:message].split()
    message_split.each do |message|
      if message.start_with?("@")
        return message.last(-1)
      end
    end
  end

  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end
end
