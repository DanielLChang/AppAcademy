import React from 'react';
import PokemonFormContainer from './pokemon_form_container';
import { withRouter } from 'react-router';

class PokemonForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: "",
      image_url: "",
      poke_type: "",
      attack: "",
      defense: "",
      moves: {}
    };

    this.updateMoves = this.updateMoves.bind(this);
    this.update = this.update.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  update(property) {
    return e => this.setState({[property]: e.target.value});
  }

  updateMoves(e) {
    this.setState({
      moves: Object.assign(
        {},
        this.state.moves,
        { [e.target.id]: e.target.value })
    });
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.createNewPokemon(this.state).then(data => this.props.router.push(`/pokemon/${data.id}`));
  }

  render() {
    return (
      <section className="pokemon-detail">
        <img src="/assets/pokemon-logo.svg" alt="Copyright of Nintendo Pokemon"/>
        <form className="pokemon-form" onSubmit={this.handleSubmit}>
            <input
              type="text"
              value={this.state.name}
              placeholder="Name"
              onChange={this.update('name')}
            />
            <input
              type="text"
              value={this.state.image_url}
              placeholder="Image Url"
              onChange={this.update('image_url')}
            />
            <select onChange={this.update("poke_type")} value={this.state.poke_type}>
              <option value="fire">fire</option>
              <option value="electric">electric</option>
              <option value="normal">normal</option>
              <option value="ghost">ghost</option>
              <option value="psychic">psychic</option>
              <option value="water">water</option>
              <option value="bug">bug</option>
              <option value="dragon">dragon</option>
              <option value="grass">grass</option>
              <option value="fighting">fighting</option>
              <option value="ice">ice</option>
              <option value="flying">flying</option>
              <option value="poison">poison</option>
              <option value="ground">ground</option>
              <option value="rock">rock</option>
              <option value="steel">steel</option>
            </select>
            <input
              type="number"
              value={this.state.attack}
              placeholder="Attack"
              onChange={this.update('attack')}
            />
            <input
              type="number"
              value={this.state.defense}
              placeholder="Defense"
              onChange={this.update('defense')}
            />
            <input
              type="text"
              id="move_1"
              value={this.state.moves.move_1 || ''}
              placeholder="Move 1"
              onChange={this.updateMoves}
            />
            <input
              type="text"
              id="move_2"
              value={this.state.moves.move_2 || ''}
              placeholder="Move 2"
              onChange={this.updateMoves}
            />
          <button>Create Pokemon</button>
        </form>
      </section>
    );
  }
}

export default withRouter(PokemonForm);
