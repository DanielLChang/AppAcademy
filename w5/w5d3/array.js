function uniq(array) {
  let result = [];
  for(let i = 0; i < array.length; i++){
    if (result.indexOf(array[i]) === -1){
      result.push(array[i]);
    }
  }
  return result;
}

// let a = [1,1,2,3,4,3,2];
// console.log(uniq(a));

function twoSum(array) {
  let pairs = [];
  for(let i = 0; i < (array.length - 1); i++) {
    for(let j = i + 1; j < array.length; j++) {
      if(array[i] + array[j] === 0) {
        pairs.push([i, j]);
      }
    }
  }
  return pairs;
}

// console.log(twoSum([-1, 0, 2, -2, 1]));

function myTranspose (array) {
  let result = [];
  for (let i = 0; i < array[0].length; i++) {
    result.push([]);
  }

  for (let i = 0; i < array.length; i++) {
    for (let j = 0; j < array[i].length; j++) {
      result[i].push(array[j][i]);
    }
  }

  return result;
}
// console.log(myTranspose([
//     [0, 1, 2],
//     [3, 4, 5],
//     [6, 7, 8]
//   ]));
