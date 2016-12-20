class View {
  constructor(game, $el) {
    this.game = game;
    this.$el = $el;

    this.setupBoard();
    this.bindEvents();
  }

  bindEvents() {
    this.$el.on("click", "li", (e => {
      const $square = $(e.currentTarget);
      this.makeMove($square);
    }));
  }

  makeMove($square) {
    const pos = $square.data('pos');
    const player = this.game.currentPlayer;
    const board = this.game.board;
    // debugger;

    if(board.isEmptyPos(pos)) {
      this.game.playMove(pos);
      $square.addClass(player);
    } else {
      alert("Invalid Move");
    }
    let $figcap = "";
    if(this.game.isOver()) {
      this.$el.addClass("gameover");
      this.$el.off("click");
      // $figcap = $('<figcaption>').html('You win!');
      if(board.winner()) {
        this.$el.addClass(`winner-${board.winner()}`);
        $figcap = $('<figcaption>').html(`Winner: ${board.winner()}`);
      }
      else {
        $figcap = $('<figcaption>').html('Game is a draw.');
      }

    }
    this.$el.append("<p>");
    this.$el.append($figcap);
  }

  setupBoard() {
    const $tiles = $('<ul>');
    $tiles.addClass("group");
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        const $li = $('<li>');
        $li.data('pos', [i,j]);
        $li.addClass("square");
        $tiles.append($li);
      }
    }
    this.$el.append($tiles);
  }
}

module.exports = View;
