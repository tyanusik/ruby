class Route
  attr_reader :first_station, :last_station, :route

  def initialize(number, first_station, last_station)
    @number = number
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
