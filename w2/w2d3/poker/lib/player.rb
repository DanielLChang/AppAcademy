class Player
  attr_reader :bankroll, :hand

  def self.buy_in(bankroll)
    Player.new(bankroll)
  end

  def initialize(bankroll)
    @bankroll = bankroll
  end

  def deal_in(hand)
    @hand = hand
  end

  def respond_bet
    begin
      print "action (call, bet, fold): "
      action = gets.chomp
      raise 'invalid action' unless ['call', 'bet', 'fold'].include?(action)
      case action
      when 'call' then :call
      when 'bet' then :bet
      when 'fold' then :fold
      end
    rescue
      retry
    end
  end

  def get_bet
    begin
      print "you have #{@bankroll}. how much to bet? "
      bet = gets.chomp.to_i
      raise 'not enough money' if bet > bankroll
    rescue
      retry
    end

    bet
  end

  def get_cards_to_trade
    print "which cards do you want to trade? (3 max)"
    card_idx = get.chomp.split(", ").map(&:to_i)
    raise "cannot trade more than three cards" unless card_idx.length <= 3
    card_idx.map { |idx| @hand.cards[idx] }
  end

  def take_bet(amount)
    raise "not enough money" if amount > @bankroll
    @bankroll -= amount
    amount
  end

  def receive_winnings(amount)
    @bankroll += amount
  end

  def return_cards
    cards_to_return = @hand.cards
    @hand = nil
    cards_to_return
  end

  def fold
    @folded = true
  end

  def unfold
    @folded = false
  end

  def folded?
    @bankroll == 0 || @folded
  end

  def trade_cards(old_cards, new_cards)
    @hand.trade_cards(old_cards, new_cards)
  end

  def <=>(other_player)
    p "your hand: #{@hand}"
    p "other hand: #{other_player.hand}"
    @hand <=> other_player.hand
  end
end
