require_relative 'user'
require_relative 'dealer'
require_relative 'logic'

loop do
  puts 'Enter your name:'
  name = gets.chomp
  user = User.new(name)
  dealer_bank = 100
  game_bank = 0
  bet = 10
  puts "#{name} and the dealer both have 100$ in the bank\n\n"

  puts "Dealer: We can start the game\n\n"
  user_hand = shuffled_deck.pop(2)
  dealer_hand = shuffled_deck.pop(2)
  dealer_hand.size

  user_points = points_count(user_hand)
  dealer_points = points_count(dealer_hand)

  cards_on_hand(user_hand, user.bank, user_points, dealer_bank, game_bank)

  loop do
    puts "Your bet is 10$\n\n"
    dealer_bank -= bet
    user.bank -= bet
    game_bank = 2 * bet + game_bank
    puts "Now game bank is #{game_bank}\n\n"

    puts "User turn \n\n"
    cards_on_hand(user_hand, user.bank, user_points, dealer_bank, game_bank)

    puts 'You have 3 options:'
    puts '1. Pass'
    puts '2. Add a card'
    puts "3. Open cards\n\n"
    input = gets.chomp.to_i
    case input
    when 1
      dealer_turn(dealer_hand, shuffled_deck)

      if hand_full?(dealer_hand) && hand_full?(user_hand)
        open_cards(user_hand, user.bank, user_points, dealer_hand, dealer_bank, dealer_points, game_bank, bet)
        break
      end

    when 2
      if user.cards == 2
        additional_card = shuffled_deck.pop(1)
        user_hand += additional_card
        user.cards += 1
        user_points = points_count(user_hand)
      else
        puts "You can't take a card. You already have 3\n\n"
      end

      puts "Your cards: #{user_hand}. Your bank score: #{user.bank}. Your points: #{user_points}\n\n"

      dealer_turn(dealer_hand, shuffled_deck)

      if hand_full?(dealer_hand) && hand_full?(user_hand)
        open_cards(user_hand, user.bank, user_points, dealer_hand, dealer_bank, dealer_points, game_bank, bet)
        break
      end

    when 3
      open_cards(user_hand, user.bank, user_points, dealer_hand, dealer_bank, dealer_points, game_bank, bet)
      break

    end
  end

  puts "Do you want to play again?\n\n"
  answer = gets.chomp
  break if answer == 'no'
end
