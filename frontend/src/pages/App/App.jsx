import React from 'react';
import { Router, Route, browserHistory } from 'react-router'
import Board from '../Board/Board.jsx';
import User from '../User/User.jsx';
import './App.css';

let App = () => {
  return (
    <Router history={browserHistory}>
      <Route exact path='/' component={Board} />
      <Route exact path='/users/:id' component={User}>
        <Route exact path='date/:date' component={User}/>
      </Route>
    </Router>
  );
};

export default App;
