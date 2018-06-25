class Card
  attr_reader :value, :quality

  def initialize(quality, suit)
    @value = "#{quality}#{suit}"
    @suit = suit
    @quality = quality
  end
end
