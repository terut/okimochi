const LOAD = 'okimochi/boards/LOAD';
const LOAD_SUCCESS = 'okimochi/boards/LOAD_SUCCESS';
const LOAD_FAIL = 'okimochi/boards/LOAD_FAIL';

import * as apiClient from '../../helpers/APIClient.js';

const initialState = {
  users: [] 
};

export default function reducer(state = initialState, action) {
  switch (action.type) {
    case LOAD:
      return {
        ...state,
        loading: true
      }
    case LOAD_SUCCESS:
      return {
        ...state,
        loading: false,
        users: action.users
      };
    case LOAD_FAIL:
      return {
        ...state,
        loading: false,
        error: action.error
      };
    default:
      return state;
  }
}

export function load(dispatch) {
  dispatch({ type: LOAD });
  apiClient.boards().then(users => {
    dispatch({
      type: LOAD_SUCCESS,
      users: users
    });
  }).catch(erro => {
    dispatch({
      type: LOAD_FAIL,
      error: error
    });
  });
}

