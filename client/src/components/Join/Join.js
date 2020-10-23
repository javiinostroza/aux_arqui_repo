import React, { useState }from "react";
import { Link } from 'react-router-dom';

import './Join.css';
import '../general.css'

const Join = () => {
    const [name, setName] = useState('');
    const [room, setRoom] = useState('');

    return (
        <div className={'Full'}>
            <div className={'Console'}>
                <div className={'Inputs'}>
                    <h1> Join </h1>
                    <div><input className='JoinInput' placeholder = "Name" type ="text" onChange={(event) => setName(event.target.value)}/></div>
                    <div><input className='JoinInput' placeholder = "Room" type ="text" onChange={(event) => setRoom(event.target.value)}/></div>
                    <Link onClick={event => (!name || !room) ? event.preventDefault() : null} to={`/chat?name=${name}&room=${room}`}>
                        <button type="submit"> Sign In</button>
                    </Link>
                </div>
            </div>
        </div>

    )
}

export default Join;