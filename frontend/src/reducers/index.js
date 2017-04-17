import { combineReducers } from 'redux'
import user from './user.js'
import boards from './boards.js';

const reducers = combineReducers({
  boards,
  user,
});

export default reducers;
