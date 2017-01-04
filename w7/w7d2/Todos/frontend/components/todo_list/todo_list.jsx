import React from 'react';
// Components
import TodoListItem from './todo_list_item';
import TodoForm from './todo_form';

class TodoList extends React.Component {

  componentDidMount() {
    this.props.requestTodos();
  }

  render() {
    const { todos, createTodo, updateTodo, destroyTodo, errors } = this.props;
    const todoItems = todos.map(todo => (
        <TodoListItem
          key={ todo.id }
          todo={ todo }
          updateTodo={ updateTodo }
          destroyTodo={ destroyTodo }/>
      )
    );

    return(
      <div>
        <ul className="todo-list">
          { todoItems }
        </ul>
        <TodoForm createTodo={ createTodo } errors={ errors }/>
      </div>
    );
  }
}

export default TodoList;
