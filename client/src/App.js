import React from "react";
import PrivateRoute from './components/PrivateRoute';
import PublicRoute from './components/PublicRoute';

import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';


import Home from './components/Home';
import Chat from './components/Chat/Chat';
import Register from './components/Register/Register'
import LogIn from './components/LogIn/LogIn'

const App = () => (
    <Router>
        <Route exact path="/" component={Home} />
        <Route exact path="/register" component={Register}/>
        <Route exact path="/login" component={LogIn} />
        <PrivateRoute exact path="/chat" component={Chat}/>
    </Router>
)

export default App;