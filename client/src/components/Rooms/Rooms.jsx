import React, { useState } from 'react';
import ScrollToBottom from 'react-scroll-to-bottom';
import { url_rooms } from "./../Routes"
import { useHistory } from 'react-router-dom';



const Rooms = ({rooms, handleEnterChat}) => (
    <select id="room-list" size="10" onChange={(event) => handleEnterChat(event)} >
        {rooms.map((item) => <option key={item.id}> {item.id}. {item.name} </option>)}
    </select>
)

export default Rooms;

