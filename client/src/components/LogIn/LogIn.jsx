import React, { useState }from "react";
import { useHistory } from 'react-router-dom';
import {url_login} from "../Routes"

import '../general.css'

const LogIn = () => {
    const history = useHistory();
    const [name, setName] = useState('');
    const [userId, setUserId] = useState('');

    const handleLoginClick = (event) => {
        var myHeaders = new Headers();
        myHeaders.append("Content-Type", "application/x-www-form-urlencoded");
        var urlencoded = new URLSearchParams();
        urlencoded.append("username", name);

        let requestOptions = {
            method: 'POST',
            headers: myHeaders,
            body: urlencoded,
            redirect: 'follow'
        };
        
        event.preventDefault();
        fetch(url_login, requestOptions)
            .then( (response) => {
                const token = response.headers.get('Authorization');
                return response.json()
                
                .then((data) => {
                    if(data.username === undefined){
                        alert("User not found")
                    }else{
                        setName(data.username);
                        setUserId(data.id);
                        window.localStorage.setItem('chat token', token);
                        history.push('/');
                        }
                    return data;
                    })
            })
            .catch((err) => {
                    console.log(err);
            });      
    }

    window.localStorage.setItem('userId', userId);

    return (
        <div className={'Full'}>
            <div className={'Console'}>
                <div className={'Inputs'}>
                    <h1> Log In </h1>
                    <div><input className='JoinInput' placeholder = "Name" type ="text" onChange={(event) => setName(event.target.value)}/></div>
                    <button type="submit" onClick={handleLoginClick}> Log In</button>
                </div>
            </div>
        </div>

    ) 
}

export default LogIn;