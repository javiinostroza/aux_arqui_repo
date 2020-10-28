import React, { useState }from "react";
import { useHistory } from 'react-router-dom';
import {url_named_user} from "../Routes"

import './Register.css';
import '../general.css'

const Register = () => {
    const history = useHistory();
    const [name, setName] = useState('');
    const [userId, setUserId] = useState('');
    const [room, setRoom] = useState('');

    const handleRegisterClick = () => {
        var requestOptions = {
            method: 'POST',
            redirect: 'follow'
        } 
        const url_ = url_named_user + name
        fetch(url_, requestOptions)
            .then( (response) => {
                return response.json()
                
            })
            .catch((err) => {
                console.log(err);
            });
        history.push('/login');
    }

    return (
        <div className={'Full'}>
            <div className={'Console'}>
                <div className={'Inputs'}>
                    <h1> Register </h1>
                    <div><input className='JoinInput' placeholder = "Name" type ="text" onChange={(event) => setName(event.target.value)}/></div>
                    <button type="submit" onClick={handleRegisterClick}> Sign Up</button>
                </div>
            </div>
        </div>

    ) 
}

export default Register;