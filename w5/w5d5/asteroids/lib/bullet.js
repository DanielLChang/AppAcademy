const Util = require("./utils");
const MovingObject = require("./moving_object");

Util.inherits(Bullet, MovingObject);

const Bullet = function(options) {
  options.radius = Bullet.RADIUS;

  MovingObject.call(this, options);
};

Bullet.RADIUS = 2;
Bullet.SPEED = 10;

Bullet.prototype.isWrappable = false;

module.exports = Bullet;
