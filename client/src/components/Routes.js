const base_url = "http://localhost:3000/"
const url_anon_user = base_url + "users/?anon=true"
const url_named_user = base_url + "users/?username="
const url_login = base_url + "login/"
const url_rooms = base_url + "rooms"
const url_add_room = base_url + "rooms/?name="
const url_display_chat = base_url + "rooms/"
const url_send_message = base_url + "sendmessage"
const url_change_email = base_url + "change_email"
const url_download_chat = base_url + "getroommessagesonpdf?room_id="
const url_upload_photo = base_url + "uploadphoto?username="


export {
    url_anon_user, 
    url_named_user, 
    url_login, 
    url_rooms, 
    url_add_room, 
    url_display_chat, 
    url_send_message, 
    url_change_email,
    url_download_chat,
    url_upload_photo
};