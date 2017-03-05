import React from 'react';
import { getUsers } from '../../APIClient.js';

import { Link } from 'react-router-dom'
import './Dashboard.css';
import { connect } from 'react-redux';

class Dashboard extends React.Component {
  componentDidMount() {
    getUsers().then(users => {
      this.props.dispatch({
        type: 'users',
        users: users
      });
    });
  }
  render () {
    return (
      <div>
        {this.props.users.users.map((user, i) => {
          return (
            <Link
              to={`/user/${user.id}`}
              className='user_card'
              onClick={() => {
              }}
              key={i}>
              {user.current_article.body}
            </Link>
          );
        })}
      </div>
    );
  }
};

export default connect(
  state => {
    return state;
  // },
  // dispatch => {
    // return {
      // onUserClick: () => {
        // dispatch({ type: 'user/detail' });
      // }
    // };
  }
)(Dashboard);

