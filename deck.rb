require_relative 'card.rb'

class Deck
  CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  SUITS = ['♥', '♣', '♦', '♠'].freeze
  def initialize
    @deck = create_deck
  end

  def one_card
    @deck.pop
  end

  def last_distr?
    @deck.size < 5
  end

  private

  def create_deck
    deck = []
    SUITS.each do |suit|
      CARDS.each do |quality|
        deck << Card.new(quality, suit)
      end
    end
    deck.shuffle
  end
end
