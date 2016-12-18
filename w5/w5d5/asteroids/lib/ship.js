const MovingObject = require('./moving_object.js');
const Util = require('./utils.js');

const DEFAULTS = { COLOR: "#1F50D2", RADIUS: 10, SPEED: 10 };

const Ship = function (options = {}) {
  options.color = DEFAULTS.COLOR;
  options.radius = DEFAULTS.RADIUS;
  options.pos = options.pos;
  options.vel = options.vel || Util.randomVec(DEFAULTS.SPEED);

  MovingObject.call(this, options);
};

Ship.prototype.power = function (impulse) {
  this.vel[0] += impulse[0];
  this.vel[1] += impulse[1];
};


Util.inherits(Ship, MovingObject);

module.exports = Ship;
