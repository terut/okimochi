
export default function user(state = { user: null }, action) {
  switch (action.type) {
    case 'user/clear':
      return {
        user: null,
        date: null
      }
    case 'user':
      return {
        user: action.user,
        date: action.date
      }; 
    case 'user/changeDate':
      state.date = action.date;
      return state;
    default:
      return state;
  }
}

