require_relative 'const.rb'

class BankManager
  def initialize
    @bank = 0
  end

  def add(dealer, user)
    dealer.money -= BET
    user.money -= BET
    @bank = BET * 2
  end

  def calc(player)
    player.money += @bank
    @bank = 0
  end

  def equal(dealer, user)
    dealer.money += @bank / 2
    user.money += @bank / 2
    @bank = 0
  end
end
