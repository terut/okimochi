import React from 'react';
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
    <div className={'article ' + (sticky ? 'article-sticky' : '')}>
      {sticky && 
          <div className='article-header article-mount'>
            <img
              className='article-avatar'
              src={user.avatar}
            />
          </div>
      }
      <pre className='article-body article-mount'>{body}</pre>
      <div className='article-footer article-mount'>
        <div className='article-date'>{article.published_on}</div>
        <div className='article-username'>{user.username}</div>
      </div>
    </div>
  );
}
