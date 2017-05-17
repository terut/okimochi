import moment from 'moment';

const LOAD = 'okimochi/users/LOAD';
const LOAD_SUCCESS = 'okimochi/users/LOAD_SUCCESS';
const LOAD_FAIL = 'okimochi/users/LOAD_FAIL';
const CHANGE_MONTH = 'okimochi/users/CHANGE_MONTH';

import * as apiClient from '../../helpers/APIClient.js';

const initialState = {
  loaded: false
};

export default function reducer(state = initialState, action) {
  switch (action.type) {
    case LOAD:
      return {
        ...state,
        loading: true,
        user: null,
      }
    case LOAD_SUCCESS:
      return {
        ...state,
        loading: false,
        user: action.user,
      };
    case LOAD_FAIL:
      return {
        ...state,
        loading: false,
        error: action.error
      };
    case CHANGE_MONTH:
      return {
        ...state,
        loading: true,
      }
    default:
      return state;
  }
}

function load(userId, date, dispatch) {
  apiClient.userMonthly(userId, date).then(user => {
    dispatch({
      type: LOAD_SUCCESS,
      user: user
    });
  }).catch(error => {
    dispatch({
      type: LOAD_FAIL,
      error: error
    });
  });
}

export function loadUser(userId, date, dispatch) {
  dispatch({ type: LOAD });
  load(userId, date, dispatch);
}

export function changeMonth(userId, date, dispatch) {
  dispatch({ type: CHANGE_MONTH });
  load(userId, date, dispatch);
}


