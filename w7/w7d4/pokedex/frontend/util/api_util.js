export const fetchAllPokemon = () => (
  $.ajax({
    method: "GET",
    url: "/api/pokemon"
  })
);

export const fetchPokemon = (id) => (
  $.ajax({
    method: "GET",
    url: `/api/pokemon/${id}`,
  })
);

export const fetchItem = (pokeId, itemId) => (
  $.ajax({
    method: "GET",
    url: `/api/pokemon/${pokeId}/items/${itemId}`
  })
);

export const createPokemon = (pokemon) => {
  pokemon.moves = Object.keys(pokemon.moves).map(k => pokemon.moves[k]);
  return $.ajax({
    method: "POST",
    url: `/api/pokemon`,
    data: { pokemon }
  });
};
