import React from 'react';

import './Input.css'

const Input = ({message, setMessage, sendMessage}) => (
    <form>
        <input
            className={'MessageInput'}
            type="text"
            placeholder="Type a message..."
            maxlength="255"
            value={message}
            onChange={(event) => setMessage(event.target.value)}
            onKeyPress={(event) => event.key === 'Enter' ? sendMessage(event) : null}
        />
        <button className={'SendButton'} onClick={(event) => sendMessage(event)}>
            Send
        </button>

    </form>

)

export default Input;