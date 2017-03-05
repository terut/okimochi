import { combineReducers } from 'redux'
import users from './users.js'
import user from './user.js'

const reducers = combineReducers({
  users,
  user
});

export default reducers;
