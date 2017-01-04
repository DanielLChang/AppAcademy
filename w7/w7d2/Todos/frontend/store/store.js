import { createStore } from 'redux';
import { applyMiddleware } from 'redux';
import thunk from '../middleware/thunk';
import RootReducer from '../reducers/root_reducer';

const configureStore = (preloadedState = {}) => {
  const store = createStore(
    RootReducer,
    preloadedState,
    applyMiddleware(thunk)
  );
  store.subscribe(() => {
    localStorage.state = JSON.stringify(store.getState());
  });

  //test if thunk middleware is working
  store.dispatch((dispatch) => {
    console.log('If this prints out, the thunk middleware is working!');
  });

  return store;
};

export default configureStore;
