import moment from 'moment';

export default function user(state = {}, action) {
  switch (action.type) {
    case 'user/clear':
      return {}
    case 'user':
      return {
        user: action.user,
        date: action.date,
        article: getDatedArticle(action.user, action.date),
      }; 
    case 'user/changeDate':
      return {
        user: state.user,
        date: action.date,
        article: getDatedArticle(state.user, action.date)
      };
    default:
      return state;
  }
}

function getDatedArticle(user, date) {
  if (!user || !user.articles || !date) {
    return;
  }
  let result;
  user.articles.forEach(article => {
    if (date.isSame(moment(article.published_on), 'date')) {
      result = article;
    }
  });
  return result;
}

