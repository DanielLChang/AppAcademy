/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const GameView = __webpack_require__(1);
	const Game = __webpack_require__(2);
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


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	const Game = __webpack_require__(2);
	// const Keymaster = require('./keymaster.js');

	function GameView (ctx, game) {
	  this.ctx = ctx;
	  this.game = game;
	}

	GameView.prototype.start = function (ctx){
	  const delta = [3, 4];

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
	// GameView.prototype.bindKeyHandlers = function () {
	//   const ship = this.ship;
	//
	//   Object.keys(GameView.MOVES).forEach((k) => {
	//     let move = GameView.MOVES[k];
	//     key(k, function () { ship.power(move); });
	//   });
	//
	//   key("space", function () { ship.fireBullet() });
	// };


	module.exports = GameView;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const Ship = __webpack_require__(3);
	const Bullet = __webpack_require__(6);
	const Asteroid = __webpack_require__(7);

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
	  this.ships.push(new Ship({pos: this.randomPosition()}));
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


/***/ },
/* 3 */
/***/ function(module, exports, __webpack_require__) {

	const MovingObject = __webpack_require__(4);
	const Util = __webpack_require__(5);

	const DEFAULTS = { COLOR: "#1F50D2", RADIUS: 10, SPEED: 10 };

	const Ship = function (options = {}) {
	  options.color = DEFAULTS.COLOR;
	  options.radius = DEFAULTS.RADIUS;
	  options.pos = options.pos;
	  options.vel = options.vel || Util.randomVec(DEFAULTS.SPEED);

	  MovingObject.call(this, options);
	};

	// Ship.prototype.power = function (impulse) {
	//   this.vel[0] += impulse[0];
	//   this.vel[1] += impulse[1];
	// };


	Util.inherits(Ship, MovingObject);

	module.exports = Ship;


/***/ },
/* 4 */
/***/ function(module, exports) {

	const Utils = ('./utils.js');

	const MovingObject = function(options) {
	  this.pos = options.pos;
	  this.vel = options.vel;
	  this.radius = options.radius;
	  this.color = options.color;
	};

	MovingObject.prototype.draw = function(ctx) {
	  ctx.fillStyle = this.color;
	  ctx.beginPath();
	  ctx.arc(
	    this.pos[0],
	    this.pos[1],
	    this.radius,
	    0,
	    2 * Math.PI,
	    false
	  );
	  ctx.fill();
	};

	MovingObject.prototype.move = function() {
	  this.pos = [this.pos[0] + this.vel[0], this.pos[1] + this.vel[1]];
	};

	MovingObject.prototype.isCollidedWith = function (otherObject) {
	  const distance = Math.sqrt((Math.pow((this.pos[0] - otherObject.pos[0]), 2) +
	    Math.pow((this.pos[1] - otherObject.pos[1]), 2)));
	  return distance < this.radius + otherObject.radius;
	};

	module.exports = MovingObject;


/***/ },
/* 5 */
/***/ function(module, exports) {

	const Util = {
	  inherits(childClass, parentClass) {
	    function Surrogate () {}
	    Surrogate.prototype = parentClass.prototype;
	    childClass.prototype = new Surrogate();
	    childClass.prototype.constructor = childClass;
	  },
	  // Return a randomly oriented vector with the given length.
	  randomVec (length) {
	    const deg = 2 * Math.PI * Math.random();
	    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
	  },
	  // Scale the length of a vector by the given amount.
	  scale (vec, m) {
	    return [vec[0] * m, vec[1] * m];
	  }
	};


	module.exports = Util;


/***/ },
/* 6 */
/***/ function(module, exports) {

	

/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

	const MovingObject = __webpack_require__(4);
	const Util = __webpack_require__(5);

	const DEFAULTS = { COLOR: "#B59573", RADIUS: 20, SPEED: 1 };

	const Asteroid = function (options = {}) {
	  options.color = DEFAULTS.COLOR;
	  options.radius = DEFAULTS.RADIUS;
	  options.pos = options.pos;
	  options.vel = options.vel || Util.randomVec(DEFAULTS.SPEED);

	  MovingObject.call(this, options);
	};

	Util.inherits(Asteroid, MovingObject);

	module.exports = Asteroid;


/***/ }
/******/ ]);