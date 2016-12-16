const readline = require("readline");
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

class Game {

  constructor() {
    this.towers = [[3, 2, 1], [], []];
  }

  promptMove(cb) {
    console.log(`Tower 1: ${this.towers[0]} Tower 2: ${this.towers[1]} Tower 3: ${this.towers[2]}`);

    reader.question("Enter from tower: ", startTowerIdx => {
      reader.question("Enter to tower: ", endTowerIdx => {
        const startInput = parseInt(startTowerIdx);
        const endInput = parseInt(endTowerIdx);
        cb(startInput, endInput);
      });
    });
  }

  isValidMove(startTowerIdx, endTowerIdx) {
    let startTower = this.towers[startTowerIdx];
    let endTower = this.towers[endTowerIdx];
    if(startTower.length === 0) {
      return false;
    } else if(endTower.length === 0) {
      return true;
    } else {
      let startDisc = startTower[startTower.length - 1];
      let endDisc = endTower[endTower.length - 1];
      return startDisc < endDisc;
    }
  }

  move(startTowerIdx, endTowerIdx) {
    if (this.isValidMove(startTowerIdx, endTowerIdx)) {
      this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
    }
  }

  print () {
    return JSON.stringify(this.towers);
  }

  isWon() {
    return (this.towers[1].length === 3 || this.towers[2].length === 3);
  }

  run(completionCallback) {
    this.promptMove((start, end) => {
      if(!this.move(start, end)) {
        console.log("invalid move");
      }
      if (!this.isWon()) {
        this.run(completionCallback);
      } else {
        console.log("You won!");
        completionCallback();
      }
    });
  }

}

const g = new Game();
const dummy1 = "Hi";
const dummy2 = "yo";
g.run(completionCallback => {
  reader.question("Do you want to play again", answer => {
    if (answer === "yes") {
      const g2 = new Game;
      g2.run(completionCallback);
    } else {
      reader.close;
    }
  });
});
