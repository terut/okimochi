



export function getUsers() {
  return new Promise((resolve, reject) => {
    resolve(require('../dummy/users.json'));
  });
}

export function getUser(id) {
  return new Promise((resolve, reject) => {
    resolve(require('../dummy/user.json'));
  });
}
