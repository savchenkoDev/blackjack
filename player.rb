class Player
  attr_reader :name
  attr_accessor :bank, :hand

  def initialize(name)
    @name = name
    @bank = 100
    @hand = []
  end

  def take_card(card)
    @hand << card
  end

  def skip_card; end

  def hand_count
    sum = 0
    @hand.each do |card|
      par = card[0..-2]
      puts "Номинал #{par}"
      sum += 'KQJA'.include?(par) ? 10 : par.to_i
    end
    sum
  end
end
