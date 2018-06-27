class Rules
  def over?(player)
    player.hand_count > 21
  end

  def take_card?(player)
    player.hand_count < 17
  end

  def victory?(dealer, user)
    user.money > 0 && dealer.money > 0
  end

  def winner(dealer, user)
    return user if over?(dealer)
    return dealer if over?(user)
    return nil if dealer.hand_count == user.hand_count
    dealer.hand_count > user.hand_count ? dealer : user
  end
end
