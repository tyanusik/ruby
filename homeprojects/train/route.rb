class Route
  attr_reader :first_station, :last_station, :stations
  attr_accessor :number

  def initialize(number, first_station, last_station)
    @number = number
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station)
    end
  end

  def list
    @stations
  end

end
