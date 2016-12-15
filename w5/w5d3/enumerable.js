Array.prototype.myEach = function(cb) {
  for(let i = 0; i < this.length; i++) {
    cb(this[i]);
  }
};

Array.prototype.myMap = function(cb) {
  let result = [];
  this.myEach(el => {
    result.push(cb(el));
  });

  return result;
};

//
// console.log([1,2,3,4].myMap(function(el) {
//   return el * el;
// }));

Array.prototype.myInject = function (cb) {
  let accum = this[0];
  this.slice(1).myEach(el => {
    accum = cb(accum, el);
  });

  return accum;
};

// console.log([1,2,3].myInject(function(accum , el) {
//   return accum + el;
// }));
