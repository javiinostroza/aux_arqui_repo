import React from 'react';

import './Message.css';

import ReactEmoji from 'react-emoji';

const Message = ({ message, name }) => {
    let isSentByCurrentUser = false;
    
    const trimmedName = name.trim().toLowerCase();

    if(message.username === trimmedName) {
        isSentByCurrentUser = true;
    }

    return (
        isSentByCurrentUser
            ? (
                // if isSentByCurrentUser is false
                <div>
                    <p><b>[{message.created_at}] {trimmedName}: {ReactEmoji.emojify(message.message)}</b></p>
                </div>
            )
            : (
                // if it's true
                <div>
                    <p>[{message.created_at}] {message.username}: {ReactEmoji.emojify(message.message)}</p>
                </div>
            )
    )


}

export default Message;