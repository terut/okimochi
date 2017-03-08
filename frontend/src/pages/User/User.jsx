import React from 'react';
import moment from 'moment';
moment.locale('ja');
import { browserHistory } from 'react-router'
import { getUser, getActivity } from '../../APIClient.js';
import { showUser } from '../../actions/index.js';

import Profile from '../../components/Profile/Profile.jsx';
import Article from '../../components/Article/Article.jsx';

import { connect } from 'react-redux';

class User extends React.Component {
  constructor(props) {
    super(props);

    this.props.dispatch({
      type: 'user/clear'
    });

    const date = this.props.params.date ? moment(this.props.params.date, 'YYYYMMDD') : null;
    getUser(this.props.params.id, date).then(user => {
      this.props.dispatch({
        type: 'user',
        user: user,
        date: date
      });
    });
  }

  handleChangeDate(date) {
    const newPath = `/users/${this.props.params.id}/date/${date.format('YYYYMMDD')}`;

    const current = this.props.date ? date : moment();
    if (!current.isSame(date, 'month')) {
      return getUser(this.props.params.id, date).then(user => {
        this.props.dispatch({
          type: 'user',
          user: user,
          date: date
        });
        browserHistory.replace(newPath);
      });
    }
    this.props.dispatch({
      type: 'user/changeDate',
      date: date
    });
    browserHistory.replace(newPath);
  }

  render() {
    if (!this.props.user) {
      return null;
    }
    const user = this.props.user;
    return (
      <div>
        <Profile
          user={user}
        />
        <Article
          articles={user.articles}
          date={this.props.date}
          onChangeDate={date => { this.handleChangeDate(date); }}
        />
      </div>
    );
  }
}

export default connect(
  state => {
    return state.user;
  }
)(User);

