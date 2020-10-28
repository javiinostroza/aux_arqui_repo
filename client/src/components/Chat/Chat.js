import React, { useState, useEffect } from "react";
import queryString from 'query-string';
import {url_display_chat, url_send_message} from "./../Routes";




import './Chat.css'
import '../general.css'

import InfoBar from '../InfoBar/InfoBar';
import Input from '../Input/Input';
import Messages from '../Messages/Messages';
let socket;



const Chat = ({ location }) => {
    const [name, setName] = useState('');
    const [room, setRoom] = useState('');
    const [messages, setMessages] = useState([]);
    const [message, setMessage] = useState('');
    const ENDPOINT = 'ec2-18-219-25-136.us-east-2.compute.amazonaws.com:5000'
    

    useEffect(() => {
        const {room, name} = queryString.parse(location.search);
        setName(name);
        setRoom(room);

        var requestOptions = {
            method: 'GET',
            redirect: 'follow'
        };
        const url_ = url_display_chat + room;
        fetch(url_, requestOptions)
            .then((response) => {
                return response.json().then((data) => {
                    const list = data.messages
                    list.sort((a,b) => {
                        if(a.created_at > b.created_at){
                            return 1
                        }else{
                            return -1
                        }
                    })
                    setMessages(list);
                    return data;
                }).catch((err) => {
                    console.log(err);
                })
            })

    }, []);

    

    const sendMessage = (event) => {
        event.preventDefault();
        var myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/x-www-form-urlencoded");

        var urlencoded = new URLSearchParams();
        urlencoded.append("user_id", window.localStorage.getItem('userId'));
        urlencoded.append("room_id", room);
        urlencoded.append("message", message);
        var requestOptions = {
        method: 'POST',
        headers: myHeaders,
        body: urlencoded,
        redirect: 'follow'
        };
        fetch(url_send_message, requestOptions)
        .then((response) => {
            return response.json().then((data) => {
                return data;
            }).catch((err) => {
                console.log(err);
            });
        })
        window.location.reload()        
    }



    return (
        <div className='Full'>
            <div className='Console'>
                <div className={'ChatContainer'}>
                    <InfoBar room={room}/>
                    <Messages messages={messages} name={name}/>
                    <Input message={message} setMessage={setMessage} sendMessage={sendMessage}/>
                </div>
            </div>
        </div>
    )
}

export default Chat;
