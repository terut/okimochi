import React from 'react';
import moment from 'moment';
import './Article.css';

export default function Article({ article, user, sticky=false }) {
  if (!article || !user) {
    return <p>お気持ち not found.</p>;
  }
  let body = article.body;
  if (sticky) {
    body = body.replace(/\n+/g, '\t');
    const elCnt = 100;
    if (body.length > elCnt) {
      body = body.slice(0, elCnt) + ' ...';
    }
  }
  return (
    <article className={'article ' + (sticky ? 'article-sticky' : '')}>
      <div className='article-mount'>
        {sticky &&
            <div className='article-avatar-space'>
              <img
                className='article-avatar'
                src={user.avatar}
              />
            </div>
        }
        <pre className='article-body'>{body}</pre>
        <div className='article-footer'>
          <div className='article-date'>{moment(article.published_on).format('YYYY/M/D')}</div>
          <div className='article-username'>{user.username}</div>
        </div>
      </div>
    </article>
  );
}
