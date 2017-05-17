import React from 'react';
import moment from 'moment';
import { browserHistory } from 'react-router'
import { loadUser, changeMonth } from '../../redux/modules/users.js';

import Profile from '../../components/Profile/Profile.jsx';
import Calendar from '../../components/Calendar/Calendar.jsx';
import Article from '../../components/Article/Article.jsx';
import './User.css';

import { connect } from 'react-redux';

class User extends React.Component {
  constructor(props) {
    super(props);
    loadUser(this.props.params.id, this.currentDate(), this.props.dispatch);
  }

  currentDate() {
    return moment(this.props.location.query.date, 'YYYY-MM-DD') || moment();
  }

  handleChangeDate(date) {
    const newPath = `/users/${this.props.params.id}?date=${date.format('YYYY-MM-DD') || ''}`;

    if (!this.currentDate().isSame(date, 'month')) {
      changeMonth(this.props.params.id, date, this.props.dispatch);
    }
    browserHistory.replace(newPath);
  }

  forcusedArticle() {
    const user = this.props.user;
    if (!user || !user.articles) {
      return;
    }
    let result;
    user.articles.forEach(article => {
      if (this.currentDate().isSame(moment(article.published_on), 'date')) {
        result = article;
      }
    });
    return result;
  }

  render() {
    const user = this.props.user;
    if (!user) {
      return null;
    }
    return (
      <div id='user-container'>
        <aside id='user-aside'>
          <section id='user-profile'>
            <Profile
              user={user}
            />
          </section>
          <section id='user-calendar'>
            <div>
              <Calendar
                date={this.currentDate()}
                articles={user.articles}
                onChangeDate={date => {
                  this.handleChangeDate(date);
                }}
              />
            </div>
          </section>
        </aside>
        <main id='user-main'>
          <div className='user-article'>
            <Article
              article={this.forcusedArticle()}
              user={user}
            />
          </div>
        </main>
      </div>
    );
  }
}

export default connect(
  state => ({
    user: state.users.user
  })
)(User);

