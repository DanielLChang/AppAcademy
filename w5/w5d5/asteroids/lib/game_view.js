const Game = require('./game.js');
// const Keymaster = require('./keymaster.js');

function GameView (ctx, game) {
  this.ctx = ctx;
  this.game = game;
}

GameView.prototype.start = function (ctx){
  const delta = [3, 4];
  this.bindKeyHandlers();

  const animateCallback = () => {
    this.game.moveObjects(delta);
    this.game.checkCollisions();
    this.game.draw(ctx);
    setTimeout(animateCallback, 20);
  };
  animateCallback();
};

// GameView.MOVES = {
//   "w": [ 0, -1],
//   "a": [-1,  0],
//   "s": [ 0,  1],
//   "d": [ 1,  0],
// };
//
GameView.prototype.bindKeyHandlers = function () {
  const ship = this.ship;

  Object.keys(GameView.MOVES).forEach((k) => {
    let move = GameView.MOVES[k];
    key(k, function () { ship.power(move); });
  });

  key("space", function () { ship.fireBullet() });
};


module.exports = GameView;
