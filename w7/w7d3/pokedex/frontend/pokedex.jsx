import React from 'react';
import ReactDOM from 'react-dom';

import { fetchAllPokemon } from './util/api_util';
import { receiveAllPokemon, requestAllPokemon } from './actions/pokemon_actions';
import { selectAllPokemon } from './reducers/selectors';
import configureStore from './store/store';
import Root from './components/root';

document.addEventListener("DOMContentLoaded", () => {

  window.fetchAllPokemon = fetchAllPokemon;
  window.receiveAllPokemon = receiveAllPokemon;
  window.requestAllPokemon = requestAllPokemon;
  window.selectAllPokemon = selectAllPokemon;

  const store = configureStore();
  window.store = store;
  const root = document.getElementById("root");
  ReactDOM.render(<Root store={store}/>, root);
});
