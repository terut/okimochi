import React from 'react';
import moment from 'moment';

import RCCalendar from 'rc-calendar';
import 'rc-calendar/assets/index.css';
import './Calendar.css';

export default function Calendar({ date, articles, onChangeDate }) {
  const articlesMap = {};
  articles.forEach(article => {
    const d = moment(article.published_on); 
    if (!d) {
      return;
    }
    articlesMap[d.format('YYYYMMDD')] = article;
  });

  return (
    <RCCalendar
      value={date}
      selectedValue={date}
      showDateInput={false}
      showToday={false}
      showWeekNumber={false}
      onChange={date => {onChangeDate(date);}}
      dateRender={(current, value) => {
        const classes = ['rc-calendar-date'];
        if (articlesMap[current.format('YYYYMMDD')]) {
          classes.push('article-calendar-exists-cell');
        }
        return (
          <div
            className={classes.join(' ')}
            aria-selected={current.isSame(value, 'date')}
            aria-disabled="false">
            {current.date()}
          </div>
        );
      }}
    />
  );
}

