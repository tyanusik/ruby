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

loop do
  puts 'Enter your name:'
  name = gets.chomp
  user = User.new(name)
  dealer_bank = 100
  puts "#{name} and the dealer both have 100$ in the bank"

  puts 'Dealer: We can start the game'
  user_hand = shuffled_deck.pop(2)
  dealer_hand = shuffled_deck.pop(2)

  puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{points_count(user_hand)}"
  puts "Dealer's cards : ** **. Dealer's bank score: #{dealer_bank}"

  puts 'Your start bet is 10$'
  start_bet = user.bank - 10
  puts "Now your bank score is #{start_bet}"

  dealer_bank -= 10

  puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{points_count(user_hand)}"
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
      additional_card = shuffled_deck.pop(1)
      user_hand += additional_card
      user.cards += 1
    end
    puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{points_count(user_hand)}"

  when 3
    puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{points_count(user_hand)}"
    puts "Dealer's cards : #{dealer_hand}. Dealer's bank score: #{dealer_bank}. Dealer's points: #{points_count(dealer_hand)}"
  end

  puts 'Dealer turn'
end
