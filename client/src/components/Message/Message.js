import React from 'react';

import './Message.css';

import ReactEmoji from 'react-emoji';

const Message = ({ message: { user, text, time}, name }) => {
    let isSentByCurrentUser = false;

    const trimmedName = name.trim().toLowerCase();

    if(user === trimmedName) {
        isSentByCurrentUser = true;
    }

    return (
        isSentByCurrentUser
            ? (
                // if isSentByCurrentUser is false
                <div>
                    <p><b>[{time}] {trimmedName}: {ReactEmoji.emojify(text)}</b></p>
                </div>
            )
            : (
                // if it's true
                <div>
                    <p>[{time}] {user}: {ReactEmoji.emojify(text)}</p>
                </div>
            )
    )


}

export default Message;