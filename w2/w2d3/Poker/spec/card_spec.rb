require 'card'
require 'rspec'

describe "Card" do
  subject(:card) { Card.new("K", "c") }
  let(:higher_value_card) { Card.new("A", "c") }
  let(:lower_value_card) { Card.new("Q", "c") }
  let(:higher_suit_card) { Card.new("K", "s") }
  let(:lower_suit_card) { Card.new("K", "d") }

  describe "#initialize" do
    it "is created with a value" do
      expect(card.value).to eq("K")
    end

    it "is created with a suit" do
      expect(card.suit).to eq("c")
    end

    context "if given value/suit is not in a real deck" do
      it "raises an error when invalid value" do
        expect { Card.new("X", "c") }.to raise_error("Invalid value.")
      end

      it "raises an error when invalid suit" do
        expect { Card.new("K", "x") }.to raise_error("Invalid suit.")
      end
    end
  end

  describe "#compare" do
    context "when two cards have the different values" do
      it "returns higher card based on value" do
        expect(card.compare(higher_value_card)).to be(higher_value_card)
        expect(card.compare(lower_value_card)).to be(card)
      end
    end

    context "when two cards have the same value but different suit" do
      it "returns higher card based on suit" do
        expect(card.compare(higher_suit_card)).to be(higher_suit_card)
        expect(card.compare(lower_suit_card)).to be(card)
      end
    end


  end
end
