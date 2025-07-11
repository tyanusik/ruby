def dealer_turn(hand, deck)
  points = points_count(hand)
  cards = hand.size
  puts "Dealer turn\n\n"

  puts "You can't take a card. You already have 3\n\n" if cards == 3

  if points < 17 && cards < 3
    additional_card = deck.pop(1)
    hand.concat additional_card
    cards += 1
    points = points_count(hand)
    puts 'Dealer takes a card'
    puts "Dealer has #{cards} cards\n\n"
    points_count(hand)
    puts "Dealer's cards : #{hand}. Dealer's points: #{points}"
  else
    points
  end
end
