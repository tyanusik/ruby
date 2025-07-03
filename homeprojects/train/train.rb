# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/company'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class Train
  include InstanceCounter
  include Company
  attr_accessor :speed, :number
  attr_reader :type, :wagons

  TYPE_FORMAT = /^\D$/
  NUMBER_FORMAT = /^[a-zа-яё\d]{3}(-?)[a-zа-яё\d]{2}$/i

  class << self
    attr_accessor :trains
  end
  self.trains = []
  # @@trains = []

  def initialize(number, type, company)
    @number = number.to_s
    @type = type
    @wagons = []
    @wagon_number = 0
    super
    self.company_name = company
    valid?
  end

  def validate!
    raise "Number can't be nil" if number.nil?
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    raise "Type can't be nil" if type.nil?

    true
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def self.find(number)
    trains.find { |train| train.number == number }
  end

  def train_type
    type
  end

  def initial_speed
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
    @wagon_number += 1
    @wagons.push(wagon)
  end

  def delete_wagon(wagon)
    @wagons.delete(wagon)
  end

  def show_wagons
    @wagons.each do |wagon|
      if type == 'passenger'
        puts "Passenger wagon #{@wagon_number} has #{wagon.free_seats} free seats and #{_wagon.taken_seats} taken seats"
      end
      if type == 'cargo'
        puts "Cargo wagon #{@wagon_number} has #{wagon.free_volume} free volume and #{_wagon.occupied_volume} taken volume"
      end
    end
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
