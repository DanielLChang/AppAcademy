import React from 'react';
import PokemonDetailContainer from './pokemon_detail_container';
import { Link } from 'react-router';

class PokemonDetail extends React.Component {
  componentDidMount() {
    this.props.requestSinglePokemon(this.props.params.pokemonId);
  }

  componentWillReceiveProps(newProps) {
    if (this.props.params.pokemonId !== newProps.params.pokemonId) {
      this.props.requestSinglePokemon(newProps.params.pokemonId);
    }
  }

  render() {
    return (
      <div>
        <ul>
          <li>name: {this.props.pokemonDetail.name}</li>
          <li>poke type: {this.props.pokemonDetail.poke_type}</li>
          <li>attack: {this.props.pokemonDetail.attack}</li>
          <li>defense: {this.props.pokemonDetail.defense}</li>
          <li><img src={this.props.pokemonDetail.image_url}></img></li>
          <li>
            <ul>
              {this.props.pokemonDetail.moves.map((move, idx) => (
                <li key={idx}>{move}</li>
              ))}
            </ul>
          </li>
          <li>
            <ul>
              {this.props.pokemonDetail.items.map((item, idx) => (
                <ul>
                  <li>
                    <Link to={`/pokemon/${this.props.pokemonDetail.id}/item/${item.id}`}>
                      <img src={item.image_url} />
                    </Link>
                  </li>
                </ul>
              ))}
              {this.props.children}
            </ul>
          </li>
        </ul>
      </div>
    );
  }
}

export default PokemonDetail;
