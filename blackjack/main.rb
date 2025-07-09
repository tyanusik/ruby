require_relative 'user'
require_relative 'dealer'

def shuffled_deck
  suits = %w[♠ ♥ ♦ ♣]
  values = %w[2 3 4 5 6 7 8 9 10 J Q K A]

  deck = suits.product(values).map { |suit, value| "#{value} #{suit}" }

  deck.shuffle
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
    end
  end
  points
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
  dealer_cards = 2

  puts ' '

  user_points = points_count(user_hand)
  dealer_points = points_count(dealer_hand)
  puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"
  puts "Dealer's cards : #{dealer_hand}. Dealer's bank score: #{dealer_bank}. Dealer's points #{dealer_points}"

  puts 'Your bet is 10$'
  user.bank -= 10
  puts "Now your bank score is #{user.bank}"

  dealer_bank -= 10

  puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"
  puts "Dealer's cards : ** **. Dealer's bank score: #{dealer_bank}"
  loop do
    puts 'User turn'
    puts 'You have 3 options:'
    puts '1. Pass'
    puts '2. Add a card'
    puts '3. Open cards'

    input = gets.chomp.to_i
    case input
    when 1
      dealer_score = dealer_turn(dealer_hand, shuffled_deck)
      puts "Dealers score is #{dealer_score}"
      puts "You are defeated. Dealer wins with #{dealer_score}." if user_points < dealer_score && dealer_score <= 21
    when 2
      if user.cards == 2
        additional_card = shuffled_deck.pop(1)
        user_hand += additional_card
        user.cards += 1
        user_points = points_count(user_hand)
      end
      puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"

    when 3
      puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"
      puts "Dealer's cards : #{dealer_hand}. Dealer's bank score: #{dealer_bank}. Dealer's points: #{dealer_points}"
      if user_points > dealer_points && user_points <= 21
        puts 'You win!'
        break
      elsif user_points == 21
        puts 'Dealer win!'
      end
    else
      puts 'There is only 3 options'
    end

    puts 'Dealer turn'
    dealer_score = dealer_turn(dealer_hand, shuffled_deck)
    if dealer_score <= 21 && dealer_score > user_points
      puts "You are defeated. Dealer wins with #{dealer_score}."
      break
    end
  end
end
