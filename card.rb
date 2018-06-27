class Card
  attr_reader :value, :quality

  QUALITIES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze
  SUITS = ['♥', '♣', '♦', '♠'].freeze

  def initialize(quality, suit)
    unless QUALITIES.include?(quality) && SUITS.include?(suit)
      raise 'Попытка создать недопустимую карту'
    end
    @value = "#{quality}#{suit}"
    @suit = suit
    @quality = quality
  end
end
