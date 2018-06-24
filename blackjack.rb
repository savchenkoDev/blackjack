require_relative 'const.rb'
require_relative 'dealer.rb'
require_relative 'player.rb'
require_relative 'user.rb'
require_relative 'interface.rb'

class Blackjack
  def initialize
    @cards = CARDS.shuffle
    @interface = Interface.new
    @bank = 0
  end

  def menu
    loop do
      answer = @interface.get_user_answer(MAIN_MENU)
      return if answer != 1
      new_game
      end
    end
  end

  def new_game
    name = if @user.nil?
             @interface.get_user_name
           else
             @user.name
           end
    @user = User.new(name)
    @dealer = Dealer.new
    @interface.show_welcome(name)
    loop do
      return if @user.bank > 0 && @dealer.bank > 0
      distribution
    end
    @interface.show_message 'Вы победили дилера' if @dealer.bank.zero?
    @interface.show_message 'Вы проиграли все деньги' if @user.bank.zero?
    menu
  end

  private

  def distribution
    @interface.new_distr
    dustribution_start
    user_turn
    dealer_turn
    bank_calculate
  end

  def dustribution_start
    @cards = CARDS if @cards.size < 5
    @dealer.bank -= BET
    @user.bank -= BET
    @bank += BET * 2
    (1..4).each do |i|
      player = i.odd? ? @user : @dealer
      player.take_card(card)
    end
  end

  def user_turn
    loop do
      show_dealer_hand
      @interface.show_hand(@user)
      @interface.show_message "#{@user.name}, Ваш ход"
      answer = @interface.get_user_answer(VARIANTS)
      return if answer != 1
      @user.take_card(card)
      show_dealer_hand
      @interface.show_hand(@user)
      return @interface.show_message 'Перебор' if @user.over?
    end
  end

  def dealer_turn
    return if @user.over?
    @interface.show_message 'Ход дилера'
    @interface.show_hand(@dealer)
    while @dealer.hand_count < 17
      @interface.show_message 'Дилер взял карту'
      @dealer.take_card(card)
      @interface.show_hand(@dealer)
      return @interface.show_message 'У дилера перебор' if @dealer.over?
    end
  end

  def bank_calculate
    @interface.show_message 'Подсчет банка'
    if @user.over?
      dealer_win
    elsif @dealer.over?
      user_win
    elsif @user.hand_count == @dealer.hand_count
      equally
    else
      @user.hand_count > @dealer.hand_count ? user_win : dealer_win
    end
    distribution_end
  end

  def card
    card = @cards.shuffle.sample
    @cards.delete(card)
    card
  end

  def dealer_win
    @interface.show_message 'Дилер выиграл.'
    @dealer.bank += @bank
  end

  def user_win
    @interface.show_message 'Вы выиграли.'
    @user.bank += @bank
  end

  def equally
    @user.bank += @bank / 2
    @dealer.bank += @bank / 2
    @bank = 0
  end

  # Interface helpers
  def show_dealer_hand
    @interface.show_dealer_hand(@dealer)
  end

  def show_hands
    @interface.show_hand(@dealer)
    @interface.show_hand(@user)
  end

  def distribution_end
    @bank = 0
    @interface.show_bank(@dealer)
    @interface.show_bank(@user)
    @user.hand = []
    @dealer.hand = []
  end
end
