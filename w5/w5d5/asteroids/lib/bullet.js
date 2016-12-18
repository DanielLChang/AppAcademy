const Util = require("./util");
const MovingObject = require("./moving_object");


const Bullet = function(options) {
  options.radius = Bullet.RADIUS;

  MovingObject.call(this, options);
};

Util.inherits(Bullet, MovingObject);

Bullet.RADIUS = 2;
Bullet.SPEED = 10;

Bullet.prototype.isWrappable = false;

module.exports = Bullet;
