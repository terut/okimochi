import { combineReducers } from 'redux'
import article from './article.js'
import boards from './boards.js';
import users from './users.js';

const reducers = combineReducers({
  article,
  boards,
  users,
});

export default reducers;
