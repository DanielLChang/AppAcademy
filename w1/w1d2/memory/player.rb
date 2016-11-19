require_relative "board"

class HumanPlayer

  def prompt
    puts "input coord x,y :"
  end

  def parse(string)
    row, col = string.split(",")
    [row.to_i, col.to_i]
  end

  def get_input
    prompt
    parse(gets.chomp)
  end

  def receive_revealed_card(pos, val)
  end

  def receive_match(pos1, pos2)
  end

end

class ComputerPlayer

  attr_reader :board, :known_cards, :matched_cards, :active_card, :active_pos

  def initialize
    @board = Board.new
    @known_cards = Hash.new
    @matched_cards = []
    @active_card = nil
    @active_pos = nil
  end

  def receive_revealed_card(pos, val)
    @active_card = val
    @active_pos = pos
    @known_cards[pos] = val
    @board[pos] = val
  end

  def receive_match(pos1, pos2)
    @matched_cards << [pos1, pos2]
    @active_card = nil
    @active_pos = nil
  end

  def get_input
    guess = nil
    value = nil
    if active_card.nil?
      if (value = knows_match)
        guess = known_guess(value)
      else
        guess = random_guess
      end
    else
      guess = find_match(active_pos, active_card) || random_guess
    end
    guess
  end

  def find_match(card_pos, card_val)
    known_cards.each do |pos, value|
      next if card_pos == pos
      return pos if card_val == value
    end
    false
  end


  def known_guess(val)
    @board.grid.each_index do |row|
      @board.grid[row].each_index do |col|
        return [row, col] if @board[[row, col]] == val
      end
    end
  end

  def knows_match
    known_cards.each_value do |val|
      next if matched_cards.any? do |pos1, _|
        @board[pos1] == val
      end
      return val if known_cards.values.count(val) > 1
    end
    false
  end

  def random_guess
    positions = []
    @board.grid.each_index do |row|
      @board.grid[row].each_index do |col|
        positions << [row, col] if @board[[row, col]] == nil
      end
    end
    positions.sample
  end
end
