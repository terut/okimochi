
export default function user(state = { user: null }, action) {
  switch (action.type) {
    case 'user':
      return {
        user: action.user
      }; 
    default:
      return state;
  }
}

