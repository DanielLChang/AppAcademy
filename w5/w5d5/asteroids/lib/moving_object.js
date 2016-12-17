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
