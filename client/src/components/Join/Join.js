import React, { useState }from "react";
import { Link } from 'react-router-dom';
import {url_named_user} from "./../Routes"

import './Join.css';
import '../general.css'

const Join = () => {
    const [name, setName] = useState('');
    const [userId, setUserId] = useState('');
    const [room, setRoom] = useState('');

    const handleLoginClick = () => {
        var requestOptions = {
            method: 'POST',
            redirect: 'follow'
        } 
        // event.preventDefault();
        const url_ = url_named_user + name
        fetch(url_, requestOptions)
            .then( (response) => {
                return response.json()
                .then((data) => {
                    console.log(data)
                })
                
            })
            .catch((err) => {
                console.log(err);
            });
    }

    return (
        <div className={'Full'}>
            <div className={'Console'}>
                <div className={'Inputs'}>
                    <h1> Join </h1>
                    <div><input className='JoinInput' placeholder = "Name" type ="text" onChange={(event) => setName(event.target.value)}/></div>
                    <Link onClick={handleLoginClick} to={`/chat?name=${name}&room=rr`}>
                        <button type="submit"> Sign In</button>
                    </Link>
                </div>
            </div>
        </div>

    ) 
}

export default Join;