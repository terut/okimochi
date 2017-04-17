export default function boards(state = { users: [], article: undefined }, action) {
  switch (action.type) {
    case 'boards/users':
      return {
        users: action.users,
        article: state.article
      }
    case 'boards/article':
      return {
        users: state.users,
        article: action.article
      }
    default:
      return state;
  }
}

