import React from 'react';
import { getUsers } from '../../APIClient.js';

import Calendar from 'rc-calendar';
import 'rc-calendar/assets/index.css';
import locale from 'rc-calendar/lib/locale/ja_JP'
import { connect } from 'react-redux';

export default class User extends React.Component {
  render() {
    console.log('oi', this.props.match.params.id);
    return (
      <div>
        user{this.props.match.params.id}
        <Calendar
          showDateInput={false}
          locale={locale}
        />
      </div>
    );
  }
}

