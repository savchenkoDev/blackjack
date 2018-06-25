require_relative 'card.rb'

class Deck
  CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  SUITS = ['♥', '♣', '♦', '♠'].freeze
  def initialize
    @@deck = []
    SUITS.each do |suit|
      CARDS.each do |quality|
        @@deck << Card.new(suit, quality)
      end
    end
  end
class << self
  def deck_shuffle
    @@deck = @@deck.shuffle
  end

  def give_one_card
    @@deck.pop
  end
end
end
