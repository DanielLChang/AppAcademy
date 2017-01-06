import { RECEIVE_SINGLE_POKEMON } from '../actions/pokemon_actions';

const defaultPokemon = {
  name: "",
  poke_type: "",
  attack: "",
  defense: "",
  image_url: "",
  moves: [],
  items: []
};

const pokemonDetailReducer = (state = defaultPokemon, action) => {
  Object.freeze(state);

  switch(action.type) {
    case RECEIVE_SINGLE_POKEMON:
      return action.pokemon;
    default:
      return state;
  }

};

export default pokemonDetailReducer;
