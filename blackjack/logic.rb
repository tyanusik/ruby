# frozen_string_literal: true

require_relative 'user'

def shuffled_deck
  suits = %w[♠ ♥ ♦ ♣]
  values = %w[2 3 4 5 6 7 8 9 10 J Q K A]

  deck = suits.product(values).map { |suit, value| "#{value} #{suit}" }

  deck.shuffle
end

def cards_on_hand(u_hand, u_bank, u_points, d_bank, g_bank)
  puts "Your cards: #{u_hand}. Your bank score: #{u_bank}. Your points: #{u_points}"
  puts "Dealer's cards : ** **. Dealer's bank score: #{d_bank}.\n\n"
  puts "Game bank is #{g_bank}"
end

def open_cards(u_hand, u_bank, u_points, d_hand, d_bank, d_points, g_bank, b)
  puts "Your cards: #{u_hand}. Your bank score: #{u_bank}. Your points: #{u_points}"
  puts "Dealer's cards : #{d_hand}. Dealer's points: #{d_points}"
  if d_points > 21 || u_points > d_points && u_points < 22
    puts "You win!\n\n"
    u_bank += g_bank
    puts "Take whole bank. Now you have #{u_bank}$"

  elsif u_points < d_points || u_points > 21 && d_points < 22
    puts "Dealer win!\n\n"
    d_bank += g_bank
    puts "Dealer takes whole bank. Now dealers bank is #{d_bank}\n\n"
  elsif u_points == d_points
    puts "It is a draw!\n\n"
    u_bank += b
    d_bank += b
    g_bank = 2 * b + g_bank
    puts "Your bets are refunded\n\n"
    puts "Now Users bank is #{u_bank}"
    puts "Now Dealers bank is #{d_bank}"
    puts "Game bank is #{g_bank}\n\n"
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
      points += 11 if points < 11
      points += 1 if points > 10
    else
      # type code here
    end
  end
  points
end
