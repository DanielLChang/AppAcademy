import React from 'react';

class TodoListItem extends React.Component {
  constructor(props) {
    super(props);

    this.handleDelete = this.handleDelete.bind(this);
    this.switchState = this.switchState.bind(this);
  }

  switchState(e) {
    e.preventDefault();
    this.props.updateTodo(this.props.todo);
  }

  handleDelete(e) {
    e.preventDefault();
    this.props.removeTodo(this.props.todo);
  }

  render() {
    return (
      <li>
        <h3>{this.props.todo.title}</h3>
        <h4>{this.props.todo.body}</h4>
        <button onClick={this.switchState}>{this.props.todo.done ? "undo" : "done"}</button>
        <button onClick={this.handleDelete}>Delete Todo</button>
      </li>
    );
  }
}

export default TodoListItem;
