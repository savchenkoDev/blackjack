require_relative 'rules.rb'

class Player
  attr_reader :name
  attr_accessor :money, :hand

  def initialize(name)
    @name = name
    @money = 100
    @hand = []
  end

  def take_card(card)
    @hand << card
  end

  def hand_count
    aces = []
    sum = 0
    @hand.each do |card|
      aces << card.quality if card.quality == 'A'
      sum += 'KQJ'.include?(card.quality.to_s) ? 10 : card.quality.to_i
    end
    aces_count(sum, aces)
  end

  private

  def aces_count(sum, aces)
    until aces.empty?
      if sum + aces.size * 11 <= 21
        aces.size.times { sum += 11 }
      else
        sum += 1
      end
      aces.pop
    end
    sum
  end
end
