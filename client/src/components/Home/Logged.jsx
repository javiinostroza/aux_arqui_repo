import React, { useState } from 'react';
import { useHistory } from 'react-router-dom';
import { url_add_room, url_rooms } from "./../Routes"
import Rooms from '../Rooms/Rooms';

const HomeLogged = () => {
    const history = useHistory();
    const [newRoomName, setNewRoomName] = useState('');
    const [rooms, setRooms] = useState([]);

    React.useEffect(() => {
        var requestOptions = {
            Accept: 'application/json',
            method: 'GET'
        };


        return fetch(url_rooms, requestOptions) 
            .then((response) => {
                try {
                    const data = response.json()
                    .then(result => {
                        setRooms(result);
                    })
                } catch (err) {
                    console.log(err);
                }
        })

    }, []);

    const handleEnterChat = (event) => {
        console.log("E: ", event);
        event.preventDefault();
        const data = event.target.value;
        var sepData = data.split(".")
        const chatId = sepData[0]
        const chatName = sepData[1]
        console.log("chat name: ", chatName);
        history.push(`/chat?name=${chatName}&room=${chatId}`);
        window.location.reload();
    }

    const handleSubmitNewRoom = (event) => { 
        var NewRoomHeader = new Headers();
        const requestOptionsAddRoom = {
            method: 'POST',
            headers: NewRoomHeader,
            redirect: 'follow'
        };
        event.preventDefault();
        const url_ = url_add_room + newRoomName
        fetch(url_, requestOptionsAddRoom)
            .then(response => response.text())
            .then(result => console.log(result))
            .catch(error => console.log('error', error));
        window.location.reload();
    }
 
    return (
        <div class="Full">
            <form class="mini-form" onSubmit={handleSubmitNewRoom}>
                <div>
                    <input type="text" onChange={(event) => setNewRoomName(event.target.value)} placeholder="room name"/>
                </div>
                <br></br>
                <div><input type="submit" value="Create Room"></input></div>
                
            </form>
            <br></br><br></br>
            <br></br><br></br>
            <br></br>
            <h3>Rooms</h3>
            <br></br> 
            <div id="rooms-list">
                <Rooms rooms={rooms} handleEnterChat={handleEnterChat} />                
            </div>
        </div>
    )
    
}

export default HomeLogged;