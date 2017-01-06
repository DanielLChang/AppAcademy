import React from 'react';
import PokemonIndexContainer from './pokemon_index_container';
import { PokemonIndexItem } from './pokemon_index_item';

class PokemonIndex extends React.Component {
  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    const pokemonItems = this.props.pokemon.map(poke =>
      (<PokemonIndexItem key={poke.id} pokemon={poke} />));
    return (
      <div className="pokedex">
        {this.props.children}
        <ul className="sidebar">
          {pokemonItems}
        </ul>
      </div>
    );
  }
}

export default PokemonIndex;
