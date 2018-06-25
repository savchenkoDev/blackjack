require_relative 'rules.rb'

class Player
  attr_reader :name
  attr_accessor :money, :hand

  def initialize(name)
    @name = name
    @money = 10
    @hand = []
    @rules = Rules.new
  end

  def over?
    hand_count > 21
  end

  def take_card(card)
    @hand << card
  end

  def skip_card; end

  def hand_count
    @rules.hand_count(self)
  end
end
