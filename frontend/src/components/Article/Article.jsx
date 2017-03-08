import React from 'react';
import moment from 'moment';
moment.locale('ja');
import { browserHistory } from 'react-router'

import Calendar from 'rc-calendar';
import 'rc-calendar/assets/index.css';
import locale from 'rc-calendar/lib/locale/ja_JP'
import './Article.css';

export default function Article({ articles, date, onChangeDate }) {
  const articlesMap = {};
  let ndate;
  articles.forEach(article => {
    const adate = moment(article.published_at);
    if (!ndate || adate.isAfter(ndate)) {
      ndate = adate;
    }
    const dateString = adate.format('YYYYMMDD');
    articlesMap[dateString] = article;
  });

  const fdate = (date) ? date : ndate;
  const article = articlesMap[fdate.format('YYYYMMDD')];
  let AD;
  if (article) {
    AD = <div>{article.body}</div>
  }

  return (
    <div id='article_calendar_box'>
      <Calendar
        value={fdate}
        selectedValue={fdate}
        showDateInput={false}
        locale={locale}
        onChange={date => {onChangeDate(date);}}
        dateRender={(current, value) => {
          const classes = ['rc-calendar-date'];
          if (articlesMap[current.format('YYYYMMDD')]) {
            classes.push('article_calendar_exists_cell');
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
      {AD}
    </div>
  );
}

