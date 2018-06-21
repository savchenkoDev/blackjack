require_relative 'const.rb'
require_relative 'dealer.rb'
require_relative 'player.rb'
require_relative 'user.rb'
require_relative 'interface.rb'

class Blackjack
  def initialize
    @cards = CARDS.shuffle
    @interface = Interface.new
  end

  def start_game
    @queue = 0
    name = @interface.get_user_name
    @user = User.new(name)
    @dealer = Dealer.new
    @cards = CARDS
    game
  end

  def queue_manager
    loop { @queue.even? ? user_move : dealer_move }
  end

  def game
    initial_dustribution
  end

  def initial_dustribution
    (1..4).each do |i|
      player = i.odd? ? @user : @dealer
      card = give_card
      player.take_card(card)
    end

    @interface.show_hand(@dealer)
    @interface.show_hand(@user)
    print "Сумма руки: #{@user.hand_count}"


  end

  def give_card
    card = @cards.shuffle.sample
    @cards.delete(card)
    card
  end
end
