
import moment from 'moment';
import request from 'superagent';

const protocol = window.location.protocol;
const host = window.location.host

export function getBoards() {
  return new Promise((resolve, reject) => {
    request.get('/boards')
      .set('accept', 'application/json')
      .end((err, res) => resolve(res.body));
  });
}

export function getUserMonthly(id, date) {
  const dateQuery = date ? `month=${date.format('YYYY-MM')}` : '';
  return new Promise((resolve, reject) => {
    request.get(`/users/${id}?${dateQuery}`)
      .set('accept', 'application/json')
      .end((err, res) => resolve(res.body));
  });
}

export function getCurrentArticle() {
  return new Promise((resolve, reject) => {
    request.get(`/article`)
      .set('accept', 'application/json')
      .end((err, res) => {
        console.log(res.statusCode);
        resolve(res.body);
      });
  });
}

export function postArticle(body) {
  return new Promise((resolve, reject) => {
    request.post('/articles')
      .set('accept', 'application/json')
      .send({
        article: {
          body: body
        }
      })
      .set('X-CSRF-Token', getCSRFToken())
      .end((err, res) => resolve(res.body));
  });
}

export function patchArticle(id, body, date) {
  return new Promise((resolve, reject) => {
    request.patch(`/articles/${id}`)
      .set('accept', 'application/json')
      .send({
        article: {
          body: body
        }
      })
      .set('X-CSRF-Token', getCSRFToken())
      .end((err, res) => resolve(res.body));
  });
}

function getCSRFToken() {
  return document.querySelector("meta[name='csrf-token']").content
}
