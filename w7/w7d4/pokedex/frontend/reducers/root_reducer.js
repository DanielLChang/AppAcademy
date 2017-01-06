import { combineReducers } from 'redux';
import pokemonReducer from './pokemon_reducer';
import pokemonDetailReducer from './pokemon_detail_reducer';
import itemDetailReducer from './item_detail_reducer';

const rootReducer = combineReducers({
  pokemon: pokemonReducer,
  pokemonDetail: pokemonDetailReducer,
  itemDetail: itemDetailReducer
});

export default rootReducer;
