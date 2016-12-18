const Ship = require('./ship.js');
const Bullet = require('./bullet.js');
const Asteroid = require('./asteroid.js');

const Game = function() {
  this.asteroids = [];
  this.ships = [];
  this.bullets = [];
  this.addAsteroids();
  this.placeShip();
};

Game.DIM_X = 1000;
Game.DIM_Y = 500;
Game.NUM_ASTEROIDS = 10;

Game.prototype.randomPosition = function() {
  const RAND_X = Game.DIM_X * Math.random();
  const RAND_Y = Game.DIM_Y * Math.random();
  return [RAND_X, RAND_Y];
};

Game.prototype.moveObjects = function(delta) {
  this.asteroids.forEach (asteroid => {
    asteroid.pos = [asteroid.pos[0] + delta[0] * asteroid.vel[0],
      asteroid.pos[1] + delta[1] * asteroid.vel[1]];
    asteroid.pos = this.wrap(asteroid.pos);
    // debugger;
  });
};

Game.prototype.placeShip = function() {
  this.ships.push(new Ship({pos: this.randomPosition(), vel: [0, 0]}));
};

Game.prototype.addAsteroids = function () {
  for (let i = 0; i < Game.NUM_ASTEROIDS; i++) {
    this.asteroids.push(new Asteroid({pos: this.randomPosition()}));
  }
};

Game.prototype.wrap = function(pos) {
  if (pos[0] > Game.DIM_X) {
    pos[0] = 0;
  } else if (pos[0] < 0) {
    pos[0] = Game.DIM_X;
  }
  if (pos[1] > Game.DIM_Y) {
    pos[1] = 0;
  } else if (pos[1] < 0) {
    pos[1] = Game.DIM_Y;
  }
  return pos;
};

Game.prototype.checkCollisions = function () {
  this.asteroids.forEach( asteroid => {
    if (asteroid.isCollidedWith(this.ships[0])) {
      this.ships.pop();
      this.placeShip();
    }
  });
};

Game.prototype.draw = function(ctx) {
  ctx.clearRect(
    0,
    0,
    Game.DIM_X,
    Game.DIM_Y
  );
  ctx.fillStyle = "#000000";
  ctx.fillRect(
    0,
    0,
    Game.DIM_X,
    Game.DIM_Y
  );
  this.allObjects().forEach (object => {
    // debugger;
    object.draw(ctx);
  });
  ctx.clearRect(
    Game.DIM_X,
    0,
    Game.DIM_X,
    Game.DIM_Y
  );
  ctx.clearRect(
    0,
    Game.DIM_Y,
    Game.DIM_X * 2,
    Game.DIM_Y
  );
};

Game.prototype.allObjects = function () {
  return [].concat(this.asteroids, this.ships, this.bullets);
};

module.exports = Game;
