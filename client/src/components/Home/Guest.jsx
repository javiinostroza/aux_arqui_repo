import React from 'react';
import { useHistory } from 'react-router-dom';

const HomeGuest = () => {
  const history = useHistory();

  const handleLoginClick = () => {
    history.push('/login');
  };
  const handleRegisterClick = () => {
    history.push('/register');
  };

  return (

    <div className={'Full'}>
        <div className={'Console'}>
            <div className={'Inputs'}>
                <h1> Welcome! </h1>
                    <button type="submit" onClick={handleLoginClick}> Log In</button>
                    <button type="submit"  onClick={handleRegisterClick}> Sign Up </button>
            </div>
        </div>
    </div>
  );
};

export default HomeGuest;