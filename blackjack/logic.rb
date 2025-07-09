require_relative 'user'

def shuffled_deck
  suits = %w[♠ ♥ ♦ ♣]
  values = %w[2 3 4 5 6 7 8 9 10 J Q K A]

  deck = suits.product(values).map { |suit, value| "#{value} #{suit}" }

  deck.shuffle
end

def add_card(_hand)
  return unless user.cards == 2

  additional_card = shuffled_deck.pop(1)
  user_hand += additional_card
  user.cards += 1
  points_count(user_hand)
end

def open_cards(u_hand, d_hand, u_points, d_points, d_bank)
  puts "Your cards: #{u_hand}. Your bank score: #{user.bank}. Your points: #{u_points}"
  puts "Dealer's cards : #{d_hand}. Dealer's bank score: #{d_bank}. Dealer's points: #{d_points}"
  if u_points > d_points && u_points <= 21
    puts 'You win!'
    break
  elsif u_points == 21
    puts 'Dealer win!'
    break
  end
end

def points_count(hand)
  points = 0
  hand.each do |card|
    value = card[0..-3]
    case value
    when '2', '3', '4', '5', '6', '7', '8', '9', '10' then points += value.to_i
    when 'J', 'Q', 'K' then points += 10
    when 'A'
      points += 11 if points <= 10
      points += 1 if points > 10
    else
      # type code here
    end
  end
  points
end
