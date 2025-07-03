# frozen_string_literal: true

require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(seats_number)
    super
    @seats_number = seats_number
    @taken_seats = 0
  end

  def occupy_seat
    return unless @taken_seats < @seats_number

    @taken_seats += 1
  end

  attr_reader :taken_seats

  def free_seats
    @seats_number - @taken_seats
  end
end
