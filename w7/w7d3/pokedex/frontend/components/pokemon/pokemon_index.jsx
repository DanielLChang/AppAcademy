import React from 'react';
import PokemonIndexContainer from './pokemon_index_container';

class PokemonIndex extends React.Component {
  // constructor(props) {
  //   super(props);
  // }

  componentDidMount() {
    this.props.requestAllPokemon();
  }

  render() {
    return (
      <div>
        <ul>
          {this.props.pokemon.map((poke, idx) => (
            <li key={idx}>
              {poke.name}
              <br></br>
              <img src={poke.image_url}/>
            </li>
          ))}
        </ul>
      </div>
    );
  }
}

export default PokemonIndex;
