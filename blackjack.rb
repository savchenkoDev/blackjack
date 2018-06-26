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
    @deck = Deck.new
    @rules = Rules.new
    @dealer = Dealer.new(@rules)
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
    create_user
    while @rules.victory?(@dealer, @user) do distribution end
    @interface.show_message(:victory) if @dealer.money.zero?
    @interface.show_message(:loose) if @user.money.zero?
  end

  def create_user
    name = @user.nil? ? @interface.input_user_name : @user.name
    @user = User.new(name, @rules)
    @interface.show_welcome(name)
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
    @deck = Deck.new if @deck.last_distr?
    @bank.add(@dealer, @user)
    2.times do
      @user.hand << @deck.one_card
      @dealer.hand << @deck.one_card
    end
  end

  def user_turn
    loop do
      show_dealer_hand
      @interface.show_hand(@user, @rules.hand_count(@user))
      return @interface.show_message(:user_over) if @rules.over?(@user)
      @interface.show_message(:user_turn)
      answer = @interface.get_user_answer(:distr_answer)
      return if answer != 1
      @user.take_card(@deck.one_card)
    end
  end

  def dealer_turn
    return if @rules.over?(@user)
    @interface.show_message(:dealer_turn)
    @interface.show_hand(@dealer, @rules.hand_count(@dealer))
    while @rules.take_card?(@dealer)
      @interface.show_message(:dealer_take_card)
      @dealer.take_card(@deck.one_card)
      @interface.show_hand(@dealer, @rules.hand_count(@dealer))
      return @interface.show_message(:dealer_over) if @rules.over?(@dealer)
    end
  end

  def winner!
    winner = @rules.winner(@dealer, @user)
    if winner.nil?
      @bank.equal(@dealer, @user)
      @interface.show_message(:equal)
    else
      name = winner.class.to_s == 'Dealer' ? :dealer_win : :user_win
      @interface.show_message(name)
      @bank.calc(winner)
    end
  end

  # INTERFACE HELPERS

  def show_dealer_hand
    @interface.show_dealer_hand(@dealer)
  end

  def show_hands
    @interface.show_hand(@dealer, @rules.hand_count(@dealer))
    @interface.show_hand(@user, @rules.hand_count(@user))
  end

  def distribution_end
    @interface.show_bank(@dealer)
    @interface.show_bank(@user)
    @user.hand = []
    @dealer.hand = []
  end
end
