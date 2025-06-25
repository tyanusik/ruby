# frozen_string_literal: true

class Route
  include InstanceCounter
  attr_reader :first_station, :last_station, :stations
  attr_accessor :number

  NUMBER_FORMAT = /^\d{3}$/.freeze

  def initialize(number, first_station, last_station)
    @number = number
    @stations = [first_station, last_station]
    register_instance
  end

  def validate!
    raise "Number can't be nil" if number.nil?
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
    raise "Station name can't be nil" if first_station.nil?
    raise "Station name can't be nil" if last_station.nil?

    true
  end

  def valid?
    validate!
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
