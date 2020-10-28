import React from 'react';

import HomeGuest from './Guest';
import HomeLogged from './Logged';

const Home = () => {
  const isLogged = window.localStorage.getItem('chat token') !== null;

  if (isLogged) {
    return <HomeLogged />;
  }

  return <HomeGuest />;
};

export default Home;
