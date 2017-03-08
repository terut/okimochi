import { getUser, getActivity } from '../APIClient.js';

export function showUser(id, date) {
  getUser(id, date).then(user => {
    this.props.dispatch({
      type: 'user',
      user: user
    });
  });
}
