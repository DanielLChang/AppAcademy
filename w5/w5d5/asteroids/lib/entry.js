const GameView = require('./game_view.js');
const Game = require('./game.js');
// const Asteroid = require('./asteroid.js');
// const MovingObject = require('./moving_object.js');

document.addEventListener("DOMContentLoaded", function() {
  const canvasEl = document.getElementsByTagName("canvas")[0];
  canvasEl.height = window.innerHeight;
  canvasEl.width = window.innerWidth;

  const ctx = canvasEl.getContext("2d");
  const g = new Game();
  new GameView(g, ctx).start();
});
