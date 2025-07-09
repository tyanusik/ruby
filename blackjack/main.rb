require_relative 'user'
require_relative 'dealer'
require_relative 'logic'

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
  puts "Dealer's cards : ** **. Dealer's bank score: #{dealer_bank}."
  puts ' '
  puts 'Your bet is 10$'
  user.bank -= 10
  puts "Now your bank score is #{user.bank}"

  dealer_bank -= 10
  puts ' '
  puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"
  puts "Dealer's cards : ** **. Dealer's bank score: #{dealer_bank}"
  puts ' '

  loop do
    puts 'User turn'
    puts 'You have 3 options:'
    puts '1. Pass'
    puts '2. Add a card'
    puts '3. Open cards'
    puts ' '
    input = gets.chomp.to_i
    case input
    when 1
      puts 'Dealer turn'
      dealer_turn(dealer_hand, shuffled_deck)

    when 2
      add_card(user_hand)
      puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"

    when 3
      puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}"
      puts "Dealer's cards : #{dealer_hand}. Dealer's bank score: #{dealer_bank}. Dealer's points: #{dealer_points}"
      if user_points > dealer_points && user_points <= 21
        puts 'You win!'
        break
      elsif user_points == 21
        puts 'Dealer win!'
        break
      end
    else
      puts ' '
      puts 'Dealer turn'
      dealer_score = dealer_turn(dealer_hand, shuffled_deck)
      if dealer_score <= 21 && dealer_score > user_points
        puts "You are defeated. Dealer wins with #{dealer_score}."
        break
      end
      break
    end

    puts 'Your bet is 10$'
    dealer_bank -= 10
    user.bank -= 10

    open_cards(user_hand, dealer_hand, user_points, dealer_points, dealer_bank) if dealer_cards == 3 && user_hand == 3
  end
end
