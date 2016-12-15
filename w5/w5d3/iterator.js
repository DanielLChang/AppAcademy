Array.prototype.bubbleSort = function () {
  let sorted = false;

  while (!sorted) {
    for (let i = 0; i < this.length - 1; i++) {
      sorted = true;
      if (this[i] > this[i+1]) {
        const temp = this[i];
        this[i] = this[i+1];
        this[i+1] = temp;
        sorted = false;
      }
    }
  }

  return this;
};

// console.log([1, 5, 3, 2].bubbleSort());

function subStrings(string) {
  let result = [];

  for (let i = 0; i < string.length; i++) {
    for (let j = 1; i + j <= string.length; j++) {
      result.push(string.slice(i, j + i));
    }
  }

  return result;
}

// console.log(subStrings("cat"));
