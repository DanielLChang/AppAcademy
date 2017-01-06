import values from 'lodash/values';

export const selectAllPokemon = (state) => {
  return values(state.pokemon);
};

export const selectPokemonItem = (state, itemId) => {
  const foundItem = state.pokemonDetail.items.find((item) => item.id === parseInt(itemId));
  return foundItem;
};
