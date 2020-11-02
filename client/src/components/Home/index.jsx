import React from 'react';

import HomeGuest from './Guest';
import HomeLogged from './Logged';

const Home = () => {
  const isLogged = window.localStorage.getItem('chat token') !== null;
  console.log("is logged: ", isLogged);

  if (isLogged) {
    return <HomeLogged />;
  }

  return <HomeGuest />;
};

export default Home;
