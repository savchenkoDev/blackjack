class Rules
  def over?(player)
    hand_count(player) > 21
  end

  def hand_count(player)
    aces = []
    sum = 0
    player.hand.each do |card|
      quality = card.quality
      aces << quality if quality == 'A'
      sum += 'KQJ'.include?(quality) ? 10 : quality.to_i
    end
    return sum if aces.empty?
    aces.size.times do
      sum += sum + 11 > 21 ? 1 : 11
    end
    sum
  end

  def winner(dealer, user)
    return user if dealer.over?
    return dealer if user.over?
    return nil if hand_count(dealer) == hand_count(user)
    hand_count(dealer) > hand_count(user) ? dealer : user
  end
end
