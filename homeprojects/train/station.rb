# frozen_string_literal: true

class Station
  include InstanceCounter

  attr_reader :trains
  attr_accessor :name

  def initialize(name)
    @name = name
    @trains = []
    super
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
