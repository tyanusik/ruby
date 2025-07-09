def dealer_turn(hand, deck)
  points = points_count(hand)
  cards = 2

  if points >= 17
    puts 'Users turn'
    points
  elsif points < 17 && cards == 2
    additional_card = deck.pop(1)
    hand += additional_card
    points = points_count(hand)
    puts 'Dealer took a card'
    points
  end
end
