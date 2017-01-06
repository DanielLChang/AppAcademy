import rootReducer from '../reducers/root_reducer';
import { createStore, applyMiddleware } from 'redux';
import { thunkMiddleware } from '../middleware/thunk';

const configureStore = () => (
  createStore(rootReducer, applyMiddleware(thunkMiddleware))
);

export default configureStore;
