# frozen_string_literal: true

require_relative 'modules/company'

class CargoWagon < Wagon
  include Company

  def initialize(type, company, volume)
    super(type, company)
    @volume = volume
    @taken_volume = 0
  end

  def occupy_volume(volume)
    return unless volume < (@volume - @taken_volume)

    @taken_volume += volume
  end

  def occupied_volume
    @taken_volume
  end

  def free_volume
    @volume - @taken_volume
  end
end
