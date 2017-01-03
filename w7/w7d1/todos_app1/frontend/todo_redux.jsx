import React from 'react';
import ReactDOM from 'react-dom';

import configureStore from './store/store';
import { allTodos } from './reducers/selectors';
import rootReducer from './reducers/root_reducer';
import { receiveTodo, receiveTodos } from './actions/todo_actions';
import Root from './components/root';

document.addEventListener('DOMContentLoaded', () => {
  let store = configureStore();
  window.store = store;
  let state = window.store.getState();
  window.state = state;
  window.todos = allTodos(window.state);
  window.receiveTodo = receiveTodo;
  window.receiveTodos = receiveTodos;

  let rootElement = document.getElementById('root');

  // debugger;
  ReactDOM.render(<Root store={store}/>, rootElement);
});
