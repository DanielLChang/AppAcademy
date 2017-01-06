import React from 'react';
import ReactDOM from 'react-dom';

import { createPokemon, fetchAllPokemon, fetchPokemon, fetchItem } from './util/api_util';
import { receiveSingleItem, receiveAllPokemon, requestAllPokemon, receiveSinglePokemon, requestSinglePokemon } from './actions/pokemon_actions';
import { selectAllPokemon, selectPokemonItem } from './reducers/selectors';
import configureStore from './store/store';
import Root from './components/root';



document.addEventListener("DOMContentLoaded", () => {
  window.fetchPokemon = fetchPokemon;
  window.receiveSinglePokemon = receiveSinglePokemon;
  window.requestSinglePokemon = requestSinglePokemon;

  window.fetchAllPokemon = fetchAllPokemon;
  window.receiveAllPokemon = receiveAllPokemon;
  window.requestAllPokemon = requestAllPokemon;
  window.selectAllPokemon = selectAllPokemon;

  window.fetchItem = fetchItem;
  window.receiveSingleItem = receiveSingleItem;
  window.selectPokemonItem = selectPokemonItem;

  window.createPokemon = createPokemon;
  const store = configureStore();
  window.store = store;
  const root = document.getElementById("root");
  ReactDOM.render(<Root store={store}/>, root);
});
