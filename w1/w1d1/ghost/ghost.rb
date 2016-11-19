require 'byebug'

class Game
  attr_accessor :players, :fragment, :dictionary

  def initialize(players, dictionary)
    @players = players
    @fragment = ""
    @dictionary = dictionary
    @losses = {}
    players.each { |player| @losses[player] = 0 }
  end

  def display_standings
    puts @losses.keys.each { |player| record(player) }
  end

  def run
    until @players.size == 1
      play_round
      if game_over?
        losses
        display_standings
      end
      @losses.each do |player, loss_count|
        @players.delete(player) if loss_count == 5
      end
    end
  end

  def play_round
    guess = current_player.guess
    until valid_play?(guess)
      current_player.alert_invalid_guess
      guess = current_player.guess
    end
    @fragment << guess
    puts current_player.name
    puts "this is the current fragment: #{@fragment}"
    next_player!
  end

  def losses
    @losses[previous_player] += 1
  end

  def record(player)
    ghost = " GHOST"
    puts "#{player.name}: #{ghost[0..@losses[player]]}"
  end

  def current_player
    @players.first
  end

  def previous_player
    @players.last
  end

  def next_player!
    @players.rotate!
  end

  def valid_play?(guess)
    return false unless ("a".."z").include?(guess.downcase)
    return false unless guess.length == 1
    temp = @fragment.dup + guess
    check_fragment(temp)
  end

  def check_fragment(fragment)
    length = fragment.length
    @dictionary.any? { |word| word[0...length] == fragment }
  end

  def game_over?
    if @dictionary.include?(@fragment)
      @fragment = ""
      true
    end
  end
end

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def guess
    gets.chomp
  end

  def alert_invalid_guess
    puts "NOOOOO"
  end
end

if $PROGRAM_NAME == __FILE__
  dictionary = File.readlines("dictionary.txt").map(&:chomp)
  mark = Player.new("Mark")
  bob = Player.new("Bob")
  clark = Player.new("Clark")
  game = Game.new([mark, bob, clark], dictionary)
  game.run
end
