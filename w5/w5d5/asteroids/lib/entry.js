const GameView = require('./game_view.js');
const Game = require('./game.js');
// const Asteroid = require('./asteroid.js');
// const MovingObject = require('./moving_object.js');

const canvasEl = document.getElementsByTagName("canvas")[0];
canvasEl.height = window.innerHeight;
canvasEl.width = window.innerWidth;

const ctx = canvasEl.getContext("2d");

// const mo = new MovingObject(
//   { pos: [30, 30], vel: [10, 10], radius: 5, color: "#00FF00"}
// ).draw(ctx);
const g = new Game();
// g.draw(ctx);

const gv = new GameView(ctx, g);
gv.start(ctx);

console.log(g);
console.log(ctx);
