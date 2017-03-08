import React from 'react';
import { Router, Route, browserHistory } from 'react-router'
import Dashboard from '../Dashboard/Dashboard.jsx';
import User from '../User/User.jsx';
import Editor from '../Editor/Editor.jsx';

let App = () => {
  return (
    <Router history={browserHistory}>
      <Route exact path='/' component={Dashboard}/>
      <Route exact path='/users/:id' component={User}>
        <Route exact path='date/:date' component={User}/>
      </Route>
      <Route exact path='/article' component={Editor}/>
    </Router>
  );
};

export default App;
