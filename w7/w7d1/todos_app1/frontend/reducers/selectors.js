export const allTodos = (state) => {
  let todoArray = [];
  for (let todo in state.todos) {
    todoArray.push(state.todos[todo]);
  }
  return todoArray;
};
