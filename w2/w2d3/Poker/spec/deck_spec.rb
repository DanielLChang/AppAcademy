require 'deck'
require 'rspec'

describe 'Deck' do
  subject(:spec_deck) { Deck.new }

  describe '#initialize' do
    it "starts with 52 cards" do
      expect(spec_deck.deck.length).to eq(52)
    end

    it "contains card objects" do
      expect(spec_deck.deck.all? { |card| card.is_a?(Card) })
    end
  end

  describe '#shuffle!' do
    it "changes the ordering of the deck" do
      second_deck = Deck.new
      expect(spec_deck.shuffle!).to_not eq(second_deck)
    end
  end

  describe '#deal' do
    it "deals one card" do
      spec_deck.deal
      expect(spec_deck.deck.length).to eq(51)
    end

    it "returns a card object" do
      expect(spec_deck.deal.class).to eq(Card)
    end
  end

end
