

export function getUsers() {
  return new Promise((resolve, reject) => {
    resolve(require('../dummy/users.json'));
  });
}

export function getUser(id, date) {
  return new Promise((resolve, reject) => {
    resolve(require('../dummy/user.json'));
  });
}

export function getTodayArticle() {
  return new Promise((resolve, reject) => {
    resolve(require('../dummy/article.json'));
  });
}

export function postArticle(body, date) {
  return new Promise((resolve, reject) => {
    resolve();
  });
}

export function editArticle(body, date) {
  return new Promise((resolve, reject) => {
    resolve();
  });
}
