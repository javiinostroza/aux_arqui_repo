import React from 'react';


const Rooms = ({rooms, handleEnterChat}) => (
    <select id="room-list" size="10" onChange={(event) => handleEnterChat(event)} >
        {rooms.map((item) => <option key={item.id}> {item.id}. {item.name} </option>)}
    </select>
)

export default Rooms;

