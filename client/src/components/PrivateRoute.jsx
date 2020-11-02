/* eslint-disable react/jsx-props-no-spreading */
import React from 'react';
import PropTypes from 'prop-types';
import { Route, Redirect } from 'react-router-dom';

const PrivateRoute = ({ component: Component, ...rest }) => {
  const getToken = () => window.localStorage.getItem('chat token');

  return (
    <Route
      {...rest}
      render={(props) => (getToken() ? <Component {...props} /> : <Redirect to="/login" />)}
    />
  );
};

PrivateRoute.propTypes = {
  component: PropTypes.oneOfType([PropTypes.func, PropTypes.node]).isRequired,
};

export default PrivateRoute;