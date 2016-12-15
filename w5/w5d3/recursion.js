function range(start, end) {
  if (end < start) {
    return [];
  }
  const prevCase = range(start + 1, end);

  return [start] + prevCase;
}

// console.log(range(1, 5));

function sumRec(array) {
  if (array.length === 0) {
    return 0;
  }

  const prevCase = sumRec(array.slice(1));

  return array[0] + prevCase;
}

// console.log(sumRec([1,2,3]));

function sumIt(array) {
  let sum = 0;

  array.forEach(el => {
    sum += el;
  });

  return sum;
}

// console.log(sumIt([1,2,3]));

function expVer1(b, exp) {
  if (exp === 0) {
    return 1;
  } else {
    return b * expVer1(b, exp - 1);
  }
}

// console.log(expVer1(2, 4));

function expVer2(b, exp) {
  if (exp === 0) {
    return 1;
  } else if (exp === 1) {
    return b;
  } else {
    if (exp % 2 === 0) {
      return expVer2(b, exp / 2) * expVer2(b, exp / 2);
    } else {
      return b * (expVer2(b, (exp - 1) / 2)) * (expVer2(b, (exp - 1) / 2));
    }
  }
}

// console.log(expVer2(2, 3));

function fibRec(n) {
  switch (n) {
    case 0:
      return [];
    case 1:
      return [1];
    case 2:
      return [1, 1];
  }
  let pC = fibRec(n - 1);

  return pC.concat([pC[pC.length - 2] + pC[pC.length - 1]]);
}

// console.log(fibRec(5));


function bSearch(ary, tar) {
  if (ary.length === 0) {
    return null;
  }

  const mid = Math.floor(ary.length / 2);

  if (ary[mid] === tar) {
    return mid;
  } else if (ary[mid] > tar) {
    return bSearch(ary.slice(0, mid), tar);
  } else {
    const right = bSearch(ary.slice(mid + 1), tar);
    if (right === null) {
      return right;
    } else return right + mid + 1;
  }
}

// console.log(bSearch([1, 2, 3], 1));
// console.log(bSearch([1, 3, 4, 5, 9], 5));
// console.log(bSearch([1, 2, 3, 4, 5, 7], 6));

function makeChange(total, coins) {
  if (total === 0) {
    return [];
  }
  let bestChange = null;

  coins.forEach((coin, index) => {
    if (coin > total) {
      return;
    }

    const remain = total - coin;
    const rChange = makeChange(remain, coins.slice(index));

    if (!rChange) {
      return;
    }

    const change = [coin].concat(rChange);

    if (!bestChange || change.length < bestChange.length) {
      bestChange = change;
    }
  });

  return bestChange;
}

// console.log(makeChange(35, [10,7,1]));

function merge(left, right) {

  let result = [];

  while (left.length > 0 && right.length > 0) {
    if (left[0] > right[0]) {
      result.push(right.shift());
    } else {
      result.push(left.shift());
    }
  }

  return result.concat(left).concat(right);

}

function mergeSort(array) {
  if (array.length < 2) {
    return array;
  }

  const mid = Math.floor(array.length / 2);
  const left = mergeSort(array.slice(0, mid));
  const right = mergeSort(array.slice(mid));

  return merge(left, right);
}

// console.log(mergeSort([3,14,3,45,24,4,3,34]));

function subSets(array) {
  if (array.length < 1) {
    return [[]];
  }
  let lastArr = array[array.length - 1];
  let subs = subSets(array.slice(0,array.length-1));
  let result = subs.map(el => el.concat([lastArr]));
  return subs.concat(result);

}

// console.log(subSets([1, 2, 3]));
