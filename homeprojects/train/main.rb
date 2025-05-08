require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative '*passenger_train'
require_relative 'cargo_train'

stations = []
trains = []
routes = []

loop do
  puts "1) Add a station"
  puts "2) Add a route"
  puts "3) Add a train"
  puts "4) Show stations list"

  input = gets.chomp.to_i

  case input
  when 1
    puts "Print station's name"
    name = gets.chomp
    stations << Station.new(name)

  when 2
    puts "Print route's number"
    number = gets.chomp

    puts "Add first station to the route"
    if stations.include?(gets.chomp)
      first_station = gets.chomp
    end

    puts "Add last station to the route"
    if stations.include?(gets.chomp)
      last_station = gets.chomp
    end
    routes << Route.new(number, first_station, last_station)

    puts "Do you want to change the route's station?"
    if gets.chomp == "yes"
      puts "1) Add a station"
      puts "2) Delete a station"
      answer = gets.chomp.to_i

      if answer == 1
        puts "Enter the station's name"
        name = gets.chomp
        if stations.include?(name)
          routes.add_station(name)
        elsif
          puts "That station doesn't exist"
        end
      end

      if answer == 2
        puts "Enter the station's name"
        name = gets.chomp
        if stations.include?(name)
          routes.delete_station(name)
        elsif
        puts "That station doesn't exist"
        end
      end

    elsif gets.chomp == "no"
      break
    end


  when 3
    puts "Print train's name"
    name = gets.chomp
    puts "Print train type: passenger or cargo"
    type = gets.chomp
    if type == "passenger"
      trains << PassengerTrain.new(name, type)
    else
      trains << CargoTrain.new(name, type)
    end

    puts "Do you want to add route to the train?"
    answer = gets.chomp
    if answer == "yes"
      puts "Enter the number of the route of the list"
      print(routes.length)
      route_number = gets.chomp.to_i
      trains.add_route(route_number)

      puts "Do you want to continue in the train menu?"
      answer = gets.chomp
      if answer == "yes"
        puts "1) Add a wagon"
        puts "2) Delete a wagon"
        answer = gets.chomp.to_i
        if answer == 1
          puts "Enter the type of the wagon"
          wagon = gets.chomp
          if trains.type == 'passenger' && wagon.passenger
            trains.add_wagon(wagon)
          elsif
            trains.type == 'cargo' && wagon.cargo
            trains.add_wagon(wagon)
          end
        elsif answer == 2
          puts "Enter the number of the wagon"
          wagon = gets.chomp.to_i
          trains.delete_wagon(wagon)
        end
      end

      puts "Do you want to move the train?"
      answer = gets.chomp
      if answer == "yes"
        puts "1) Move forward"
        puts "2) Move backward"
        answer = gets.chomp.to_i
        if answer == 1
          trains.move_to_next
        end
        if answer == 2
          trains.move_to_previous
        end
      elsif answer == "no"
        break
      end


    elsif answer == "no"
      break
    end

  when 4
    puts stations

  else
    # type code here
  end


  break if input.nil?

end
