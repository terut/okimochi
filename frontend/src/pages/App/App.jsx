import React from 'react';
import {
  BrowserRouter as Router,
  Route
} from 'react-router-dom'
import Dashboard from '../Dashboard/Dashboard.jsx';
import User from '../User/User.jsx';

let App = () => {
  return (
    <Router>
      <div>
        <Route exact path='/' component={Dashboard}/>
        <Route exact path='/user/:id' component={User}/>
      </div>
    </Router>
  );
};

export default App;
