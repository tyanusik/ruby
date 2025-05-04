class Station
  attr_reader :trains


  def initialize(name)
    @name = name
    @trains = []
  end  

  def add_trains(train)
    @trains << train
  end

  def current_trains 
    @trains.each {|trains| puts trains}
    
  end

  def trains_type 
    passenger_trains = @trains.count {|trains| trains.type == 'passenger'}
    cargo_trains = @trains.count {|trains| trains.type == 'cargo'}

    puts "Passengers trains: #{passenger_trains}, Cargo trains: #{cargo_trains}"
    
    return passenger_trains, cargo_trains

  end

  def delete_train(train)
    @trains.delete(train)
  end  
  
end 


class Route
  attr_reader :first_station, :last_station, :route

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @route = [@first_station, @last_station]
  end  

  def add_station(station)
    @route.insert(-2, station)
  end

  def delete_station(station)
    @route.delete(station)
  end

  def list
    @route 
  end

end



class Train
  attr_accessor :speed
  attr_reader :type, :wagons_number


  def initialize(number, type, wagons_number)
    @number = number
    @type = type
    @wagons_number = wagons_number
  end  

  def speed 
    @speed = 0
  end  

  def current_speed
    @speed
  end  

  def go
    @speed = 45
  end
  def stop
    @speed = 0
  end

  def wagons_number
    self.wagons_number
  end

  def add_wagons
    @wagons_number += 1 if @speed == 0
  end

  def delete_wagons
    @wagons_number -= 1 if @speed == 0
  end

  def add_route(route)
    @route = route
    @current_station = route.list.first
  end  

  def move_to_next
    @index = @route.list.index(@current_station)
    @current_station = @route.list[@index + 1] if @index < @route.list.size - 1
  end  
  
  def move_to_previous
    @index = @route.list.index(@current_station)
    @current_station = @route.list[@index - 1] if @index < @route.list.size - 1
  end  
  
  def previous_current_next
    @index = @route.list.index(@current_station)
    previous_st = @route.list[@index - 1]
    next_st = @route.list[@index + 1]
    puts "Previous station: #{previous_st}, Current station: #{current_station}, Next station: #{next_st}"
  end  

end