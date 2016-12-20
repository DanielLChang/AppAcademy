/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const HanoiGame = __webpack_require__(1);
	const HanoiView = __webpack_require__(2);

	$( () => {
	  const rootEl = $('.hanoi');
	  const game = new HanoiGame();
	  new HanoiView(game, rootEl);
	  // console.log('hi');
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	class Game {
	  constructor() {
	    this.towers = [[3, 2, 1], [], []];
	  }

	  isValidMove(startTowerIdx, endTowerIdx) {
	      const startTower = this.towers[startTowerIdx];
	      const endTower = this.towers[endTowerIdx];

	      if (startTower.length === 0) {
	        return false;
	      } else if (endTower.length == 0) {
	        return true;
	      } else {
	        const topStartDisc = startTower[startTower.length - 1];
	        const topEndDisc = endTower[endTower.length - 1];
	        return topStartDisc < topEndDisc;
	      }
	  }

	  isWon() {
	      // move all the discs to the last or second tower
	      return (this.towers[2].length == 3) || (this.towers[1].length == 3);
	  }

	  move(startTowerIdx, endTowerIdx) {
	      if (this.isValidMove(startTowerIdx, endTowerIdx)) {
	        this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
	        return true;
	      } else {
	        return false;
	      }
	  }

	  print() {
	      console.log(JSON.stringify(this.towers));
	  }

	  promptMove(reader, callback) {
	      this.print();
	      reader.question("Enter a starting tower: ", start => {
	        const startTowerIdx = parseInt(start);
	        reader.question("Enter an ending tower: ", end => {
	          const endTowerIdx = parseInt(end);
	          callback(startTowerIdx, endTowerIdx)
	        });
	      });
	  }

	  run(reader, gameCompletionCallback) {
	      this.promptMove(reader, (startTowerIdx, endTowerIdx) => {
	        if (!this.move(startTowerIdx, endTowerIdx)) {
	          console.log("Invalid move!");
	        }

	        if (!this.isWon()) {
	          // Continue to play!
	          this.run(reader, gameCompletionCallback);
	        } else {
	          this.print();
	          console.log("You win!");
	          gameCompletionCallback();
	        }
	      });
	  }
	}

	module.exports = Game;


/***/ },
/* 2 */
/***/ function(module, exports) {

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


/***/ }
/******/ ]);