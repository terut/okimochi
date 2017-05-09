import React from 'react';
import moment from 'moment';
moment.locale('ja');
import { browserHistory } from 'react-router'
import { getUser, getActivity } from '../../APIClient.js';
import { showUser, changeUserDate } from '../../actions/index.js';

import Profile from '../../components/Profile/Profile.jsx';
import Calendar from '../../components/Calendar/Calendar.jsx';
import Article from '../../components/Article/Article.jsx';
import './User.css';

import { connect } from 'react-redux';

class User extends React.Component {
  constructor(props) {
    super(props);

    const date = moment(this.props.location.query.date, 'YYYY-MM-DD');
    showUser(this.props.params.id, date, this.props.dispatch);
  }

  handleChangeDate(date) {
    const newPath = `/users/${this.props.params.id}?date=${date.format('YYYY-MM-DD') || ''}`;

    const shownDate = this.props.date ? this.props.date : moment();
    if (!shownDate.isSame(date, 'month')) {
      showUser(this.props.params.id, date, this.props.dispatch);
    } else {
      changeUserDate(date, this.props.dispatch);
    }
    browserHistory.replace(newPath);
  }

  componentWillUnmount() {
    this.props.dispatch({
      type: 'user/clear'
    });
  }

  render() {
    if (!this.props.user) {
      return null;
    }
    const user = this.props.user;
    return (
      <div id='user-container'>
        <aside id='user-aside'>
          <section id='user-profile'>
            <Profile
              user={user}
            />
          </section>
          <section>
            <div className='user-calendar'>
              <Calendar
                date={this.props.date}
                articles={user.articles}
                onChangeDate={date => { this.handleChangeDate(date); }}
              />
            </div>
          </section>
        </aside>
        <main id='user-main'>
          <div className='user-article'>
            <Article
              article={this.props.article}
              user={user}
            />
          </div>
        </main>
      </div>
    );
  }
}

export default connect(
  state => {
    return state.user;
  }
)(User);

