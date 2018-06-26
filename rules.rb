class Rules
  def over?(player)
    hand_count(player) > 21
  end

  def take_card?(player)
    hand_count(player) < 17
  end

  def victory?(dealer, user)
    user.money > 0 && dealer.money > 0
  end

  def hand_count(player)
    aces = []
    sum = 0
    player.hand.each do |card|
      aces << card.quality if card.quality == 'A'
      sum += 'KQJ'.include?(card.quality.to_s) ? 10 : card.quality.to_i
    end
    aces_count(sum, aces)
  end

  def winner(dealer, user)
    return user if over?(dealer)
    return dealer if over?(user)
    return nil if hand_count(dealer) == hand_count(user)
    hand_count(dealer) > hand_count(user) ? dealer : user
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
