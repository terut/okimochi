
import moment from 'moment';
import request from 'superagent';

function getCSRFToken() {
  return document.querySelector("meta[name='csrf-token']").content
}

export function boards() {
  return new Promise((resolve, reject) => {
    request.get('/boards')
      .set('accept', 'application/json')
      .end((err, res) => {
        if (err) {
          return reject(err);
        }
        resolve(res.body)
      });
  });
}

export function article() {
  return new Promise((resolve, reject) => {
    request.get(`/article`)
      .set('accept', 'application/json')
      .end((err, res) => {
        if (err) {
          return reject(err);
        }
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
      .end((err, res) => {
        if (err) {
          return reject(err);
        }
        resolve(res.body)
      });
  });
}

export function editArticle(id, body, date) {
  return new Promise((resolve, reject) => {
    request.patch(`/articles/${id}`)
      .set('accept', 'application/json')
      .send({
        article: {
          body: body
        }
      })
      .set('X-CSRF-Token', getCSRFToken())
      .end((err, res) => {
        if (err) {
          return reject(err);
        }
        resolve(res.body)
      });
  });
}

export function userMonthly(id, date) {
  const dateQuery = date ? `month=${date.format('YYYY-MM')}` : '';
  return new Promise((resolve, reject) => {
    request.get(`/users/${id}?${dateQuery}`)
      .set('accept', 'application/json')
      .end((err, res) => {
        if (err) {
          return reject(err);
        }
        resolve(res.body)
      });
  });
}

