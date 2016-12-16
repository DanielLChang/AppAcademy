let Board = require('./board');

const readline = require("readline");
const reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});


class Game {

  constructor(reader) {
    this.reader = reader;
    this.board = new Board();
  }

  promptMove(cb) {
    console.log(this.board);
    reader.question("Enter a move: ", pos => {
      const input = [];
      pos.split(', ').forEach (el => {
        input.push(parseInt(el));
      });
      cb(input);
    });
  }

  run(completionCallback) {
    this.promptMove((pos) => {

      if(this.board.isValidMove(pos)) {
        this.board.move(pos);
      } else {
        console.log("invalid move");
      }

      if (this.board.isWon()) {
        console.log("you won");
        completionCallback();
      } else {
        this.run(completionCallback);

      }
    });
  }

}




const g = new Game(reader);

g.run(completionCallback => {
  reader.question("Do you want to play again", answer => {
    if (answer === "yes") {
      let g2 = new Game;
      g2.run(completionCallback);
    } else {
      reader.close;
    }
  });
});
