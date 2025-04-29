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
    passenger_trains = @trains.count {|trains| train.type == 'passenger'}
    cargo_trains = @trains.count {|trains| train.type == 'cargo'}

    puts {'Passengers trains: #{passenger_trains}, Cargo trains: #{cargo_trains}'}
    
    return passenger_trains, cargo_trains

  end

  def delete_train(train)
    @trains.delete(train)
  end  
  
end 


class Route
  attr_reader :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @stations = []
  end  

  def add_station(station)
    @stations.insert(-1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def route_list
    @list = [@first_station, @stations, @last_station]
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
    route.route_list
    @current_station = route.first_station
  end  

  def move_to_next
    @current
  end  
  
  def move_to_previous

  end  
  
  def current_station

  end  

end