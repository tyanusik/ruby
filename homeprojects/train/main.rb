# frozen_string_literal: true

require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'modules/company'

def list_with_index(array)
  array.each_with_index { |item, index| puts "#{index + 1}. #{block_given? ? yield(item) : item}" }
end

def choose_from(array)
  list_with_index(array) { |item| item.respond_to?(:name) ? item.name : item.number }
  index = gets.chomp.to_i - 1
  array[index] if index.between?(0, array.length - 1)
end

stations = []
trains = []
routes = []

loop do
  puts "\nMain Menu:"
  puts '1) Manage stations'
  puts '2) Manage routes'
  puts '3) Manage trains'
  puts '4) Exit'

  case gets.chomp.to_i
  when 1
    puts '1) Add a station'
    puts '2) Show all stations'
    input = gets.chomp.to_i
    if input == 1
      puts "Print station's name"
      name = gets.chomp
      stations << Station.new(name)
      puts "Station #{name} is added"
    elsif input == 2
      stations.each do |station|
        puts "Station #{station.name}"
        stations.trains.each do |_train|
          # puts "Train #{train.number}, it's type is #{trains.type} and has #{trains.wagons} wagons"
          stations.current_trains
          trains.wagons.each { |_wagon| trains.show_wagons }
        end
      end
    end

  when 2
    puts '1) Create a route'
    puts '2) Edit a route'
    puts '3) Show all routes'

    input = gets.chomp.to_i
    case input
    when 1
      puts "Print route's number"
      number = gets.chomp.to_i
      puts 'Add first station to the route'
      first_station = choose_from(stations)

      puts 'Add last station to the route'
      last_station = choose_from(stations)

      if first_station && last_station
        routes << Route.new(number, first_station, last_station)
        puts "Route #{number} is created"
      end

    when 2
      puts 'Select route to edit:'
      route = choose_from(routes)
      if route
        puts "You choose #{route.number}"
        puts '1) Add a station'
        puts '2) Delete a station'

        input = gets.chomp.to_i - 1
        if input == 1
          puts 'Select station to add:'
          station = choose_from(stations)
          route.add_station(station) if station
        elsif input == 2
          puts 'Select station to delete:'
          station = choose_from(route.stations[1..-2])
          route.delete_station(station) if station
        end
      end

    when 3
      routes.each_with_index do |r, i|
        puts "#{i + 1}) #{r.number}: #{r.stations.map(&:name).join(' -> ')}"
      end
    end

  when 3
    puts '1) Create a train'
    puts '2) Assign a route to a train'
    puts '3) Manage wagons'
    puts '4) Move train'
    puts '5) Show all trains'

    input = gets.chomp.to_i

    case input
    when 1
      attempt = 0
      begin
        puts "Print train's number"
        number = gets.chomp

        puts 'Print train type: passenger or cargo'
        type = gets.chomp
        puts 'Print train company'
        company = gets.chomp

        temp_train = Train.new(number, type, company)
        temp_train.validate!

        trains << (if type == 'passenger'
                     PassengerTrain.new(number, type, company)
                   else
                     CargoTrain.new(number, type, company)
                   end)
        puts "Train #{number} is created"
      rescue RuntimeError => e
        puts "Error: #{e.message}"
        attempt += 1
        retry if attempt < 3
      ensure
        puts "There was #{attempt} attempts"
      end

    when 2
      puts 'Select a train:'
      train = choose_from(trains)
      puts 'Select a route:'
      route = choose_from(routes)
      train.add_route(route) if route
      puts "The #{route.number} was added to the train #{train.number}"
      current_station = train.current_station
      puts "Current station is #{current_station}"

    when 3
      puts 'Select a train:'
      train = choose_from(trains)
      puts '1) Add a wagon'
      puts '2) Delete a wagon'
      puts '3) Select a wagon'
      puts '4) Show all wagons'
      input = gets.chomp.to_i

      if input == 1
        if train.type == 'passenger'
          wagon = PassengerWagon.new(train.type, train.company_name, wagon.seats_number)
          train.add_wagon(wagon)
          puts "Wagon with #{free_seats} seats is created"
        elsif train.type == 'cargo'
          wagon = CargoWagon.new(train.type, train.company_name, wagon.volume)
          train.add_wagon(wagon)
          puts "Wagon with #{free_volume} volume is created"
        end
      end

      train.delete_wagon(wagon) if input == 2

      if input == 3
        puts 'Select a wagon from the list'
        choose_from(train.show_wagons)
        puts 'Enter the number of the wagon'
        gets.chomp.to_i

      end
      train.show_wagons if input == 4

    when 4
      puts 'Select a train:'
      train = choose_from(trains)
      puts '1) Move forward'
      puts '2) Move backward'
      input = gets.chomp.to_i
      if input == 1
        train.move_to_next
        puts "Current station is #{current_station}"
      end
      if input == 2
        train.move_to_previous
        puts "Current station is #{current_station}"
      end

    when 5
      list_with_index(trains)
    else
      # type code here
    end

  when 4
    puts 'Exiting...'
    break

  else
    puts 'Invalid option. Try again.'
  end
end
