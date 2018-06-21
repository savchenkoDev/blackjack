class Interface
  def get_user_name
    show_line INPUT_NAME
    gets.chomp
  end

  def show_hand(player)
    return show_dealer_hand(player) if player.class == Dealer
    show_line "Ваши карты: "
    player.hand.each { |card| show_line "-#{card}"}
    puts
  end

  private

  def show_dealer_hand(player)
    show_line "Карты дилера: "
    show_line('❓')
    cards = player.hand[1..-1]
    cards.each { |card| show_line "-#{card}" }
    puts
  end

  def show_line(line)
    print line
  end
end
