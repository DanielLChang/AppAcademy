import React from 'react';
import uniqueId from '../../util/util';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = { title: "", body: "" };

    this.updateTitle = this.updateTitle.bind(this);
    this.updateBody = this.updateBody.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  updateTitle(e) {
    this.setState({title: e.target.value});
  }

  updateBody(e) {
    this.setState({body: e.target.value});
  }

  handleSubmit(e) {
    e.preventDefault();
    let newTodo = { id: uniqueId(),
                    title: this.state.title,
                    body: this.state.body
    };
    this.props.receiveTodo(newTodo);
  }

  render() {
    return(
      <div>
        <h2>Submit a Todo Item</h2>
        <label>
          Title
        </label>
          <input type="text"
                 value={this.state.title}
                 onChange={this.updateTitle}>
          </input>
        <label>
          Body
          <input type="text"
                 value={this.state.body}
                 onChange={this.updateBody}>
          </input>
        </label>
        <button onClick={this.handleSubmit}>Submit Todo</button>
      </div>
    );
  }

}

export default TodoForm;
