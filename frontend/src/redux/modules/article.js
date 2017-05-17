
const LOAD = 'okimochi/article/LOAD';
const LOAD_SUCCESS = 'okimochi/article/LOAD_SUCCESS';
const LOAD_FAIL = 'okimochi/article/LOAD_FAIL';
const POST = 'okimochi/article/POST';
const POST_SUCCESS = 'okimochi/article/POST_SUCCESS';
const POST_FAIL = 'okimochi/article/POST_FAIL';

import * as apiClient from '../../helpers/APIClient.js';

const initialState = {
  loaded: false,
};

export default function reducer(state = initialState, action) {
  switch (action.type) {
    case LOAD:
      return {
        ...state,
        loading: true
      };
    case LOAD_SUCCESS:
      return {
        ...state,
        loading: false,
        loaded: true,
        article: action.article,
      };
    case LOAD_FAIL:
      return {
        ...state,
        loading: false,
        error: action.error
      };
    case POST:
      return {
        ...state,
        posting: true
      };
    case POST_SUCCESS:
      return {
        ...state,
        posting: false,
        article: action.article
      };
    case POST_FAIL:
      return {
        ...state,
        posting: false,
        error: action.error
      };
    default:
      return state;
  }
}

export function load(dispatch) {
  dispatch({ type: LOAD });
  apiClient.article().then(article => {
    dispatch({
      type: LOAD_SUCCESS,
      article: article
    });
  }).catch(error => {
    dispatch({
      type: LOAD_FAIL,
      error: error
    });
  });
}

export function post(body, dispatch) {
  dispatch({ type: POST });
  apiClient.postArticle(body).then(article => {
    dispatch({
      type: POST_SUCCESS,
      article: article
    });
  }).catch(error => {
    dispatch({
      type: POST_FAIL,
      error: error
    });
  });
}

export function edit(articleId, body, dispatch) {
  dispatch({ type: POST });
  apiClient.editArticle(articleId, body).then(article => {
    dispatch({
      type: POST_SUCCESS,
      article: article
    });
  }).catch(error => {
    dispatch({
      type: POST_FAIL,
      error: error
    });
  });
}
