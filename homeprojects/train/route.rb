# frozen_string_literal: true

class Route
  include InstanceCounter
  attr_reader :first_station, :last_station, :stations
  attr_accessor :number

  def initialize(number, first_station, last_station)
    @number = number
    @stations = [first_station, last_station]
    super
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return unless station != @stations.first && station != @stations.last

    @stations.delete(station)
  end

  def list
    @stations
  end
end
