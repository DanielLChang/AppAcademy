class View {
  constructor (game, $rootEl) {
    this.game = game;
    this.$rootEl = $rootEl;
    this.startIdx = null;
    this.endIdx = null;

    this.setupTowers();
    this.bindEvents();
  }
}

View.prototype.setupTowers = function() {
  const $towerOne = $('<ul>');
  const $towerTwo = $('<ul>');
  const $towerThr = $('<ul>');

  this.$rootEl.append($towerOne, $towerTwo, $towerThr);
  $towerOne.addClass("tower");
  $towerOne.attr("id", 0);

  $towerTwo.addClass("tower");
  $towerTwo.attr("id", 1);

  $towerThr.addClass("tower");
  $towerThr.attr("id", 2);

  for(let i=0; i < 3; i++) {
    const $li = $("<li>");
    $li.data("size", i);
    $li.addClass("disc");
    $li.attr('id', `disc${i}`);
    $towerOne.append($li);
  }

};

View.prototype.clickTower = function(tower) {
  if (this.startIdx === null) {
    this.startIdx = parseInt(tower.attr("id"));
  }
  else {
    this.endIdx = parseInt(tower.attr("id"));
    // debugger;
    if (this.game.move(this.startIdx, this.endIdx)) {
      // debugger;
      this.render();
    } else {
      alert("invalid move");
    }
    this.startIdx = null;
    this.endIdx = null;
    if (this.game.isWon()) {
      alert("Good work, you");
      this.$rootEl.addClass("gamewon");
    }
  }
};

View.prototype.bindEvents = function() {
  this.$rootEl.on("click", "ul", e => {
    const $tower = $(e.currentTarget);
    this.clickTower($tower);
  });
};

View.prototype.render = function() {
  // const tower = this.game.towers[this.startIdx];
  // idToMove = tower[tower.length - 1];
  const startTower = $('#' + this.startIdx);
  const discToMove = startTower.children().first();
  const endTower = $('#' + this.endIdx);
  endTower.prepend(discToMove);
  // debugger;



};

module.exports = View;
