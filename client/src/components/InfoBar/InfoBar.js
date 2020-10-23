import React from 'react';

import './InfoBar.css'

const InfoBar = ( { room }) => (
    <div className={'Bar'}>
        <div className={'Left'}>
            <h3>Room: {room} | Status: Online</h3>
        </div>
        <div className={'Right'}>
            <h3><a href='/'>Exit room</a></h3>
        </div>
    </div>
)

export default InfoBar;