
export default function users(state = { users: [] }, action) {
  switch (action.type) {
    case 'users':
      return {
        users: action.users
      }; 
    default:
      return state;
  }
}

