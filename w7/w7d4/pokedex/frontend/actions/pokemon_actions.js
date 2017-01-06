import * as ApiUtil from '../util/api_util';

export const RECEIVE_ALL_POKEMON = "RECEIVE_ALL_POKEMON";
export const RECEIVE_SINGLE_POKEMON = "RECEIVE_SINGLE_POKEMON";
export const RECEIVE_SINGLE_ITEM = "RECEIVE_SINGLE_ITEM";
export const RECEIVE_NEW_POKEMON = "RECEIVE_NEW_POKEMON";

export const receiveAllPokemon = (pokemon) => ({
  type: RECEIVE_ALL_POKEMON,
  pokemon
});

export const receiveSinglePokemon = (pokemon) => ({
  type: RECEIVE_SINGLE_POKEMON,
  pokemon
});

export const receiveSingleItem = (item) => ({
  type: RECEIVE_SINGLE_ITEM,
  item
});

export const receiveNewPokemon = (pokemon) => ({
  type: RECEIVE_NEW_POKEMON,
  pokemon
});

export const requestAllPokemon = () => (dispatch) => {
  ApiUtil.fetchAllPokemon().then((pokemon) => dispatch(receiveAllPokemon(pokemon)));
};

export const requestSinglePokemon = (id) => (dispatch) => {
  ApiUtil.fetchPokemon(id).then((poke) => dispatch(receiveSinglePokemon(poke)));
};

export const requestSingleItem = (pokeId, itemId) => (dispatch) => {
  ApiUtil.fetchItem(pokeId, itemId).then((item) => dispatch(receiveSingleItem(item)));
};

export const createNewPokemon = (data) => (dispatch) => (
  ApiUtil.createPokemon(data).then((pokemon => {
    dispatch(receiveNewPokemon(pokemon));
    return pokemon;
  }))
);
