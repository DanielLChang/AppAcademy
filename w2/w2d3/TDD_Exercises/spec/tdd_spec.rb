require "tdd"
require "rspec"

describe "#my_uniq" do
  it "takes in an array" do
    expect {my_uniq(5)}.to raise_error(ArgumentError)
  end
  it "removes duplicated from an array" do
    expect(my_uniq([1, 2, 1, 3, 3])).to eq([1, 2, 1, 3, 3].uniq)
  end
end

describe "Array#two_sum" do
  subject(:a) { [-1, 0, 2, -2, 1] }

  it "finds all pairs of numbers that equal 0" do
    expect(a.two_sum).to eq([[0, 4], [2, 3]])
  end
end

describe "my_transpose" do
  subject(:a) { [[0, 1, 2], [3, 4, 5], [6, 7, 8]] }
  subject(:b) { [[0, 1], [2, 3, 4], [5, 6, 7]] }
  subject(:c) { [[0, 1, 2], [3, 4], [5, 6]] }

  it "takes in 2D array" do
    expect {my_transpose(5)}.to raise_error("not an array")
    expect {my_transpose([1, 2, 3])}.to raise_error(ArgumentError)
  end

  it "transposes 3x3 matrix" do
    expect(my_transpose(a)).to eq( [[0, 3, 6], [1, 4, 7], [2, 5, 8]] )
  end

  it "transposes uneven matrix" do
    expect(my_transpose(b)).to eq( [[0, 2, 5], [1, 3, 6]] )
    expect(my_transpose(c)).to eq( [[0, 3, 5], [1, 4, 6], [2, nil, nil]] )
  end
end

describe "stock_picker" do
  subject(:stock_prices) { [5, 2, 1, 9] }

  it "takes in an array" do
    expect {stock_picker(5)}.to raise_error(ArgumentError)
  end

  it "has more than one day" do
    expect{stock_picker([3])}.to raise_error("not enough days")
  end

  it "gives the pair of most profitable days to buy then sell" do
    expect(stock_picker(stock_prices)).to eq([2, 3])
  end

end

describe "Towers of Hanoi" do
  subject(:game) { Towers.new }

  describe "#initialize" do
    it "starts with 3 discs on left" do
      expect(game.towers[0]).to eq([1, 2, 3])
    end

    it "other 2 towers are empty" do
      expect(game.towers[1]).to eq([])
      expect(game.towers[2]).to eq([])
    end
  end

  describe "#valid_move?" do
    it "can't move from empty tower" do
      expect(game.valid_move?(1, 0)).to be false
    end

    it "can move to empty tower" do
      expect(game.valid_move?(0, 1)).to be true
    end

    it "can't move a bigger disc onto a smaller disc" do
      game.move(0, 1)
      expect(game.valid_move?(0, 1)).to be false
    end

    it "can't move to the same tower" do
      expect(game.valid_move?(0, 0)).to be false
    end
  end

  describe "#move" do
    it "executes the move" do
      game.move(0, 1)
      expect(game.towers).to eq([[2, 3], [1], []])
    end
  end

  describe "#won?" do
    it "checks that a game with more than 1 filled tower is not won" do
      game.move(0, 1)
      expect(game.won?).to be false
    end

    it "checks that a game is won" do
      game.move(0, 1)
      game.move(0, 2)
      game.move(1, 2)
      game.move(0, 1)
      game.move(2, 0)
      game.move(2, 1)
      game.move(0, 1)
      expect(game.won?).to be true
    end
  end
end
