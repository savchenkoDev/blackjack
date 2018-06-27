require_relative 'card.rb'

class Deck
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
    Card::SUITS.each do |suit|
      Card::QUALITIES.each do |quality|
        deck << Card.new(quality, suit)
      end
    end
    deck.shuffle
  end
end
