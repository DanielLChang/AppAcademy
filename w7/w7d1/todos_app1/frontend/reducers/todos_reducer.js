import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO, UPDATE_TODO } from '../actions/todo_actions';
import merge from 'lodash/merge';

const initialState = {
  1: {
    id: 1,
    title: "wash car",
    body: "with soap",
    done: false
  },
  2: {
    id: 2,
    title: "wash dog",
    body: "with shampoo",
    done: true
  },
};

const todosReducer = (state = initialState, action) => {
  Object.freeze(state);
  let newState = merge({}, state);
  switch(action.type) {
    case RECEIVE_TODOS:
      newState = {};
      action.todos.forEach((todo) => {
        newState[todo.id] = todo;
      });
      return newState;
    case RECEIVE_TODO:
      let newTodo = {[action.todo.id]: action.todo};
      newState = merge(newTodo, state);
      return newState;
    case REMOVE_TODO:
      delete newState[action.todo.id];
      return newState;
    case UPDATE_TODO:
      let updatedTodo = action.todo;
      action.todo.done = !action.todo.done;
      newState = merge({[action.todo.id]: updatedTodo}, state);
      return newState;
    default:
      return state;
  }
};

export default todosReducer;
