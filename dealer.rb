require_relative 'player.rb'
class Dealer < Player
  def initialize(rules)
    super('Dealer', rules)
  end
end
