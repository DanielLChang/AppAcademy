require_relative "card"
require_relative "board"
require_relative "player"

class Game

  attr_accessor :board, :previous_guess, :player, :previous_pos

  def initialize(player)
    @board = Board.new
    @previous_guess = nil
    @previous_pos = nil
    @player = player
  end

  def play
    board.populate

    until game_over?
      board.render
      guess = player.get_input
      until valid_play?(guess)
        puts "invalid"
        guess = player.get_input
      end
      make_guess(guess)
      system("clear")
    end

    puts "you win"
  end

  def game_over?
    board.won?
  end

  def valid_play?(guess)
    row, col = guess
    return false if row >= board.grid.size
    return false if col >= board.grid.first.size
    true
  end

  def make_guess(guess)
    guessed_card = board.reveal(guess)
    player.receive_revealed_card(guess, guessed_card.value)
    if self.previous_guess.nil?
      self.previous_guess = guessed_card
      self.previous_pos = guess
    else
      if guessed_card == previous_guess
        sleep(1)
        player.receive_match(guess, previous_pos)
      else
        system("clear")
        board.render
        sleep(1)
        guessed_card.hide
        previous_guess.hide
      end
      self.previous_guess = nil
      self.previous_pos = nil
    end
  end

end

if __FILE__ == $0

  player = ComputerPlayer.new
  # player = HumanPlayer.new

  game = Game.new(player)
  game.play

end
