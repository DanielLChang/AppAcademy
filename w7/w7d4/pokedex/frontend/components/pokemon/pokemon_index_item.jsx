import React from 'react';
import { Link } from 'react-router';

export const PokemonIndexItem = ({ pokemon }) => (
  <li>
    <Link to={`/pokemon/${pokemon.id}`}>
      {pokemon.name}
      <br></br>
      <img src={pokemon.image_url}/>
    </Link>
  </li>
);
