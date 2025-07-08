require_relative 'user'

def shuffled_deck
  suits = %w[♠ ♥ ♦ ♣]
  values = %w[2 3 4 5 6 7 8 9 10 J Q K A]

  deck = suits.product(values).map { |suit, value| "#{value} #{suit}" }

  deck.shuffle
end

def points_count(hand)
  points = 0
  hand.each do |card|
    value = card[0..-2]
    case value
    when 'J', 'Q', 'K' then points += 10
    when 'A'
      points += 11 if points <= 10
      points += 1 if points > 10
    else
      points += value.to_i
    end
  end
end

def dealer_turn(hand, shuffled_deck)
  loop do
    hand = shuffled_deck.pop(2)
    dealer_points = points_count(hand)

    if dealer_points < 17
      additional_card = shuffled_deck.pop(1)
      hand + additional_card
    elsif dealer_points >= 17
      break
    end
    points_count(hand)
  end
end

loop do
  puts 'Enter your name:'
  name = gets.chomp
  user = User.new(name)
  dealer_bank = 100
  puts "#{name} and the dealer both have 100$ in the bank"

  puts 'Dealer: We can start the game'
  user_hand = shuffled_deck.pop(2)
  dealer_hand = shuffled_deck.pop(2)

  user_points = points_count(user_hand)
  dealer_points = points_count(dealer_hand)
  puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"
  puts "Dealer's cards : ** **. Dealer's bank score: #{dealer_bank}"

  puts 'Your bet is 10$'
  bet = user.bank - 10
  puts "Now your bank score is #{bet}"

  dealer_bank -= 10

  puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"
  puts "Dealer's cards : ** **. Dealer's bank score: #{dealer_bank}"

  puts 'User turn'
  puts 'You have 3 options:'
  puts '1. Pass'
  puts '2. Add a card'
  puts '3. Open cards'

  input = gets.chomp.to_i
  case input
  when 1
  when 2
    if user.cards == 2
      additional_card = shuffled_deck.pop
      user_hand += additional_card
      user.cards += 1
    end
    puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"

  when 3
    puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"
    puts "Dealer's cards : #{dealer_hand}. Dealer's bank score: #{dealer_bank}. Dealer's points: #{dealer_points}"
    if user_points > dealer_points && user_points <= 21
      puts 'You win!'
    elsif user_points == 21
      puts 'Dealer win!'
    end
  else
    puts 'There is only 3 options'
  end

  puts 'Dealer turn'
  dealer_score = dealer_turn(dealer_hand, shuffled_deck)
  puts "You are defeated. Dealer wins with #{dealer_score}." if dealer_score <= 21
end
