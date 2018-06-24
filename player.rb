class Player
  attr_reader :name
  attr_accessor :bank, :hand

  def initialize(name)
    @name = name
    @bank = 100
    @hand = []
  end

  def over?
    hand_count > 21
  end

  def take_card(card)
    @hand << card
  end

  def skip_card; end

  def hand_count
    aces = []
    sum = 0
    @hand.each do |card|
      par = card[0..-2]
      aces << par if par == 'A'
      sum += 'KQJ'.include?(par) ? 10 : par.to_i
    end
    return sum if aces.empty?
    aces.size.times do
      sum += sum + 11 > 21 ? 1 : 11
    end
    sum
  end
end
