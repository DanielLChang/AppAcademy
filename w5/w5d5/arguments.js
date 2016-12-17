function sumArguments() {
  let total = 0;
  for (let i = 0; i < arguments.length; i++) {
    total += arguments[i];
  }
  return total;
}

function sumRest(...args) {
  let total = 0;
  for (let i = 0; i < args.length; i++) {
    total += args[i];
  }
  return total;
}

Function.prototype.myBind = function(context) {
  return () => {
    this.apply(context);
  };
};

Function.prototype.myBindArguments = function(context) {
  const bindArgs = Array.from(arguments).slice(1);
  const that = this;
  return function() {
    const callArgs = Array.from(arguments);
    return that.apply(context, bindArgs.concat(callArgs));
  };
};

Function.prototype.myBind = function (context, ...bindArgs) {
  return (...callArgs) => {
    return this.apply(context, bindArgs.concat(callArgs));
  };
};


Function.prototype.myBindRest = function(context) {
  const bindArgs = Array.from(arguments).slice(1);
  const that = this;
  return (...callArgs) => {
    return that.apply(context, bindArgs.concat(callArgs));
  };
};

function curriedSum(numArgs) {
  const numbers = [];

  function _curriedSum(num) {
    numbers.push(num);

    if(numbers.length === numArgs) {
      let sum = 0;
      numbers.forEach(el => {
        sum += el;
      });
      return sum;
    } else {
      return _curriedSum;
    }
  }

  return _curriedSum;
}

Function.prototype.curry = function(numArgs) {
  const numbers = [];
  const that = this;

  function _curry(num) {
    numbers.push(num);

    if (numbers.length === numArgs) {
      return that.apply(null, numbers);
    } else {
      return _curry;
    }
  }

  return _curry;
};

Function.prototype.curryRest = function(numArgs) {
  const numbers = [];
  const that = this;

  function _curry(num) {
    numbers.push(num);

    if (numbers.length === numArgs) {
      return that(...numbers);
    } else {
      return _curry;
    }
  }

  return _curry;
};


function sumThree(num1, num2, num3) {
  return num1 + num2 + num3;
}

console.log(sumThree.curry(3)(4)(20)(6)); // == 30

console.log(sumThree.curryRest(3)(5)(16)(12)); // == 33
