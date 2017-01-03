import React from 'react';
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

const TodoList = (props) => (
  <div>
    <ul>
      {props.todos.map((todo, idx) => {
        return <TodoListItem key={idx} todo={todo}
                             removeTodo={props.removeTodo}
                             updateTodo={props.updateTodo} />;
      })}
    </ul>
    <TodoForm receiveTodo={props.receiveTodo}/>
  </div>
);

export default TodoList;
