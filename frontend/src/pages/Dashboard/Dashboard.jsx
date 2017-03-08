import React from 'react';
import { getUsers } from '../../APIClient.js';

import { Link } from 'react-router'
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
        <div>
          <Link to='/article'>Edit</Link>
        </div>
        {this.props.users.map((user, i) => {
          return (
            <Link
              to={`/users/${user.id}`}
              className='dashboard_user_article'
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
    return state.users;
  }
)(Dashboard);

