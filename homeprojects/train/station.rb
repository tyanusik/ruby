# frozen_string_literal: true

require_relative 'modules/instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains
  attr_accessor :name

  NAME_FORMAT = /^\D$/.freeze

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    valid?
  end

  def validate!
    raise "Station name can't be nil" if name.nil?
    raise 'Station name has invalid format' if name !~ NAME_FORMAT

    true
  end

  def valid?
    validate!
  end

  def self.all
    @stations.each { |station| puts station }
  end

  def add_trains(train)
    @trains << train
  end

  def current_trains
    @trains.each { |trains| puts trains }
  end

  def trains_type
    passenger_trains = @trains.count { |trains| trains.type == 'passenger' }
    cargo_trains = @trains.count { |trains| trains.type == 'cargo' }

    puts "Passengers trains: #{passenger_trains}, Cargo trains: #{cargo_trains}"
  end

  def delete_train(train)
    @trains.delete(train)
  end
end
