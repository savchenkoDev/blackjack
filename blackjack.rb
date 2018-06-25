require_relative 'const.rb'
require_relative 'dealer.rb'
require_relative 'player.rb'
require_relative 'user.rb'
require_relative 'interface.rb'
require_relative 'deck.rb'
require_relative 'rules.rb'
require_relative 'bank.rb'

class Blackjack
  def initialize
    @deck = create_deck
    @rules = Rules.new
    @interface = Interface.new
    @bank = BankManager.new
  end

  def menu
    loop do
      answer = @interface.get_user_answer(:main_menu)
      return if answer != 1
      new_game
    end
  end

  private

  def new_game
    name = @user.nil? ? @interface.get_user_name : @user.name
    @user = User.new(name)
    @dealer = Dealer.new
    @interface.show_welcome(name)
    while @user.money > 0 && @dealer.money > 0 do distribution end
    @interface.show_message(:victory) if @dealer.money.zero?
    @interface.show_message(:loose) if @user.money.zero?
    menu
  end

  def distribution
    @interface.new_distr
    dustribution_start
    user_turn
    dealer_turn
    winner!
    distribution_end
    @interface.next_distr
  end

  def dustribution_start
    @deck = Deck.new if @deck.size < 5
    @bank.add(@dealer, @user)
    2.times do
      @user.hand << one_card
      @dealer.hand << one_card
    end
  end

  def user_turn
    loop do
      show_dealer_hand
      @interface.show_hand(@user)
      return @interface.show_message(:user_over) if @rules.over?(@user)
      @interface.show_message(:user_turn)
      answer = @interface.get_user_answer(:distr_answer)
      return if answer != 1
      @user.take_card(one_card)
    end
  end

  def dealer_turn
    return if @rules.over?(@user)
    @interface.show_message(:dealer_turn)
    @interface.show_hand(@dealer)
    while @dealer.hand_count < 17
      @interface.show_message(:dealer_take_card)
      @dealer.take_card(one_card)
      @interface.show_hand(@dealer)
      return @interface.show_message(:dealer_over) if @rules.over?(@dealer)
    end
  end

  def create_deck
    deck = []
    SUITS.each do |suit|
      CARDS.each do |quality|
        deck << Card.new(quality, suit)
      end
    end
    deck.shuffle
  end

  def one_card
    @deck.pop
  end

  def winner!
    winner = @rules.winner(@dealer, @user)
    name = case winner.class.to_s
           when 'Dealer' then :dealer_win
           when 'User' then :user_win
           end
    if winner.nil?
      @bank.equal(@dealer, @user)
      @interface.show_message(:equal)
    else
      @interface.show_message(name)
      @bank.calc(winner)
    end
  end

  # INTERFACE HELPERS

  def show_dealer_hand
    @interface.show_dealer_hand(@dealer)
  end

  def show_hands
    @interface.show_hand(@dealer)
    @interface.show_hand(@user)
  end

  def distribution_end
    @interface.show_bank(@dealer)
    @interface.show_bank(@user)
    @user.hand = []
    @dealer.hand = []
  end
end
