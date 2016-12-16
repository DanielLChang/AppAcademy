
class Board {

  constructor() {
    this.grid = this.makeGrid();
    this.currentMark = "x";
  }

  makeGrid () {
    const grid = [];
    for (let i = 0; i < 3; i++) {
      grid.push([]);
      for(let j = 0; j < 3; j++) {
        grid[i].push(null);
      }
    }
    return grid;
  }

  switchMark() {
    this.currentMark = this.currentMark === "x" ? "o" : "x";
  }

  isValidMove (move) {
    return this.grid[move[0]][move[1]] === null;
  }

  move(pos) {
    if (this.isValidMove(pos)) {
      this.grid[pos[0]][pos[1]] = this.currentMark;
      this.switchMark();
    }
  }

  print() {
    JSON.stringify(this.grid);
  }

  isWon() {
    let horizontals = [[[0,0],[0,1],[0,2]],
                       [[1,0],[1,1],[1,2]],
                       [[2,0],[2,1],[2,2]]];

    let verticals = [[[0,0],[1,0],[2,0]],
                    [[0,1],[1,1],[2,1]],
                    [[0,2],[1,2],[2,2]]];

    let diagonals = [[[0,0],[1,1],[2,2]],
                    [[0,2],[1,1],[2,0]]];

    let won = false;

    horizontals.forEach(row => {
      if((this.grid[row[0][0]][row[0][1]] === this.grid[row[1][0]][row[1][1]]) &&
        (this.grid[row[0][0]][row[0][1]] === this.grid[row[2][0]][row[2][1]]) &&
        ((this.grid[row[0][0]][row[0][1]] === "x") || (this.grid[row[0][0]][row[0][1]] === "o"))){
          won = true;
        }
      });
    verticals.forEach(row => {
      if((this.grid[row[0][0]][row[0][1]] === this.grid[row[1][0]][row[1][1]]) &&
        (this.grid[row[0][0]][row[0][1]] === this.grid[row[2][0]][row[2][1]]) &&
        ((this.grid[row[0][0]][row[0][1]] === "x") || (this.grid[row[0][0]][row[0][1]] === "o"))){
          won = true;
        }
      });
    diagonals.forEach(row => {
      if((this.grid[row[0][0]][row[0][1]] === this.grid[row[1][0]][row[1][1]]) &&
        (this.grid[row[0][0]][row[0][1]] === this.grid[row[2][0]][row[2][1]]) &&
        ((this.grid[row[0][0]][row[0][1]] === "x") || (this.grid[row[0][0]][row[0][1]] === "o"))){
          won = true;
        }
      });
    return won;
  }


}

// const b = new Board();
// b.grid[0][0] = "x";
// b.grid[1][1] = "x";
// b.grid[2][2] = "x";
// console.log(b.grid);
// console.log(b.isWon());

module.exports = Board;
