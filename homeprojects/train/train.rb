# frozen_string_literal: true

require_relative 'modules'

class Train
  include InstanceCounter
  attr_accessor :speed, :number
  attr_reader :type, :wagons

  class << self
    attr_accessor :trains
  end

  self.trains = []
  # @@trains = []

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    self.class.trains << self
    super
  end

  def self.find(number)
    trains.find { |train| train.number == number }
  end

  def train_type
    type
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
    @stations = route
    @current_st_index = 0
    current_station.add_trains(self)
  end

  def current_station
    @stations.stations[@current_st_index] if @stations
  end

  def move_to_next
    return if @current_st_index == @stations.stations.length - 1

    current_station.delete_train(self)
    @current_st_index += 1
    current_station.add_trains(self)
  end

  def move_to_previous
    return if @current_st_index == @stations.stations.length - 1

    current_station.delete_train(self)
    @current_st_index -= 1
    current_station.add_trains(self)
  end

  def previous_current_next
    index = @current_st_index
    previous_st = index.positive? ? @stations.list[index - 1] : 'none'
    current_st = current_station.name
    next_st = index < @stations.length - 1 ? @stations.stations[index + 1] : 'none'
    puts "Previous station: #{previous_st}, Current station: #{current_st}, Next station: #{next_st}"
  end
end
