require 'hand'
require 'rspec'

describe "Hand" do
  subject(:spec_hand) { Hand.new }
  let(:card1) { double("card1", value: "K", suit: "s") }
  let(:card2) { double("card2", value: "Q", suit: "s") }
  let(:card3) { double("card3", value: "Q", suit: "c") }
  let(:card4) { double("card4", value: "Q", suit: "d") }
  let(:card5) { double("card5", value: "Q", suit: "h") }
  before(:each) do
    spec_hand.hand = [card1, card2, card3, card4, card5]
  end

  describe "#initialize" do
    it "starts with card objects" do
      expect(spec_hand.all? { |card| card.is_a?(Card) }).to be true
    end

    it "starts with 5 cards" do
      expect(spec.hand.length).to eq(5)
    end

  end

  describe "#compare_hands" do
    subject(:spec_hand2) { Hand.new }
    spades_a = Card.new("A", "s")
    spades_k = Card.new("K", "s")
    spades_q = Card.new("Q", "s")
    spades_j = Card.new("J", "s")
    spades_t = Card.new("10", "s")
    hearts_a = Card.new("A", "h")
    hearts_k = Card.new("K", "h")
    hearts_q = Card.new("Q", "h")
    hearts_j = Card.new("J", "h")
    hearts_t = Card.new("10", "h")
    clubs_a = Card.new("A", "c")
    clubs_k = Card.new("K", "c")
    clubs_q = Card.new("Q", "c")
    clubs_j = Card.new("J", "c")
    clubs_t = Card.new("10", "c")
    diamonds_a = Card.new("A", "d")
    diamonds_k = Card.new("K", "d")
    diamonds_q = Card.new("Q", "d")
    diamonds_j = Card.new("J", "d")
    diamonds_t = Card.new("10", "d")

    straight_flush1 = [spades_a, spades_k, spades_q, spades_j, spades_t]
    straight_flush2 = [hearts_a, hearts_k, hearts_q, hearts_j, hearts_t]
    it "compares straight flushes" do
      expect(straight_flush1.compare_hands(straight_flush2)).to eq(straight_flush1)
    end

  end

  describe "#discard_card" do
    it "does not discard if hand has < 3" do
      spec_hand.hand = [card1, card2]
      expect { spec_hand.discard_card(card1) }.to raise_error("too few cards")
    end

    it "returns the card to discard" do
      expect(spec_hand.discard_card(card1)).to eq(card1)
    end

    it "removes the specified card" do
      spec_hand.discard_card(card1)
      expect(spec_hand.hand.length).to eq(4)
      expect(spec_hand.hand).to eq([card2, card3, card4, card5])
    end
  end

  describe "add_card" do
    it "adds a card to hand" do
      spec_hand = [card1, card2]
      expect(spec_hand.add_card(card3)).to eq([card1, card2, card3])
      expect(spec_hand.hand.length).to eq(3)
    end
  end
end
