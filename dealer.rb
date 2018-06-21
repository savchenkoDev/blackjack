require_relative 'player.rb'
class Dealer < Player
  def initialize
    super('Dealer')
  end

  def take_card(cards)
    # return if hand_count >= 17
    super
  end


end
