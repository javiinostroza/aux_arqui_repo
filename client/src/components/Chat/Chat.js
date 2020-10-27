import React, { useState, useEffect } from "react";
import queryString from 'query-string';
import {url_display_chat} from "./../Routes";
import io from 'socket.io-client';

// IMPORTAR ROUTES PARA MENSAJES Y CHAT. Y TERMINAR ESTO


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

        socket = io(ENDPOINT);

        setName(name);
        setRoom(room);
        console.log("name: ", name);
        console.log("room: ", room);

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
                    console.log("estos son los mensajes: ", data)
                    return data;
                }).catch((err) => {
                    console.log(err);
                })
            })



        socket.emit('join', {name, room}, () =>{

        });
        socket.on('messages', (messages) => {
            console.log("mensajes de ellos: ", messages);
            setMessages(messages);
        })

        socket.on('message', (message) => {
            console.log(message);
            setMessages(messages => [...messages, message]);
        });

        return () => {
            socket.emit('disconnect', {room, name});
            socket.off();
        }


    }, [ENDPOINT, location.search]);

    

    const sendMessage = (event) => {
        event.preventDefault();

        if (message[0] === '/'){
            let command = message.substring(1).trim().toLowerCase();
            socket.emit('command', {command, name, room}, () => setMessage(''));

        } else if (message) {
            socket.emit('sendMessage', {message, name, room}, () => setMessage(''));
        }

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
