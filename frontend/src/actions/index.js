import * as apiClient from '../APIClient.js';
import request from 'superagent';

export function initBoard(dispatch) {
  if (!dispatch || typeof dispatch !== 'function') {
    return;
  }
  apiClient.getBoards().then(users => {
    dispatch({
      type: 'boards/users',
      users: users
    });
  });
  request.get(`/article`)
    .end((err, res) => {
      dispatch({
        type: 'boards/article',
        article: res.body
      });
    });
}

export function showBoard(dispatch) {
  if (!dispatch || typeof dispatch !== 'function') {
    return;
  }
  apiClient.getBoards().then(users => {
    dispatch({
      type: 'boards/users',
      users: users
    });
  });
}

export function showUser(id, date, dispatch) {
  apiClient.getUserMonthly(id, date).then(user => {
    dispatch({
      type: 'user',
      user: user,
      date: date
    });
  });
}

export function changeUserDate(date, dispatch) {
  dispatch({
    type: 'user/changeDate',
    date: date
  });
}

export function getCurrentArticle(dispatch) {
  request.get(`/article`)
    .end((err, res) => {
      dispatch({
        type: 'boards/article',
        article: res.body
      });
    });
}

export function postArticle(body, dispatch) {
  apiClient.postArticle(body).then(article => {
    initBoard(dispatch);
  });
}

export function editArticle(id, body, dispatch) {
  apiClient.patchArticle(id, body).then(article => {
    initBoard(dispatch);
  });

}


