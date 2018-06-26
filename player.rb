require_relative 'rules.rb'

class Player
  attr_reader :name
  attr_accessor :money, :hand

  def initialize(name, rules)
    @name = name
    @money = 100
    @hand = []
    @rules = rules
  end

  def take_card(card)
    @hand << card
  end

  def hand_count
    @rules.hand_count(self)
  end
end
