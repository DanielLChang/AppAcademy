import { RECEIVE_SINGLE_ITEM } from '../actions/pokemon_actions';

const defaultItem = {
  name: "",
  price: -1,
  happiness: -1,
};

const itemDetailReducer = (state = defaultItem, action) => {
  Object.freeze(state);
  switch (action.type) {
    case RECEIVE_SINGLE_ITEM:
      return action.item;
    default:
      return state;
  }
};

export default itemDetailReducer;
