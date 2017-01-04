export const thunkMiddleware = ({dispatch, getState}) => next => action => {
  if (typeof action === 'function'){
    return action(dispatch);
  } else {
    return next(action);
  }
};
