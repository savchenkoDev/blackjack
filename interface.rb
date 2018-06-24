class Interface
  def get_user_name
    show_line INPUT_NAME
    gets.chomp
  end

  def show_welcome(name)
    puts "#{name}, добро пожаловать в Блэкджек"
  end

  def show_message(message)
    puts message
    delimiter
  end

  def show_line(line)
    print line

  end

  def delimiter
    puts '♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠♠'
  end

  def new_distr
    delimiter
    puts 'Новая раздача'
    delimiter
  end

  def show_bank(player)
    name = get_player_name(player)
    puts "Банк #{name}: #{player.bank}"
  end

  def get_user_answer(list)
    show_list(list)
    show_line 'Ваш выбор > '
    gets.to_i
  end

  def show_hand(player)
    name = get_player_name(player)
    show_line "Карты #{name}: "
    player.hand.each { |card| show_line "|#{card}|" }
    show_message "Сумма руки: #{player.hand_count}"
    delimiter
  end

  def get_player_name(player)
    case player.class.to_s
    when 'Dealer' then 'дилера'
    when 'User' then 'игрока'
    end
  end


  def show_dealer_hand(dealer)
    show_line 'Карты дилера: '
    show_line('|❔|')
    cards = dealer.hand[1..-1]
    cards.each { |card| show_line "|#{card}|" }
    puts
  end

  private

  def show_list(list)
    list.each.with_index(1) { |elem, index| puts "#{index}. #{elem}" }
  end
end
