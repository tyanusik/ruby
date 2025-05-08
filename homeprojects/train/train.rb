class Train
  attr_accessor :speed
  attr_reader :type, :wagons


  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
  end  

  def train_type
    self.type
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

  def add_wagon(wagon)
    @wagons.push(wagon)
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon)
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