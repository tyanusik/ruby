# frozen_string_literal: true

class CargoWagon < Wagon
  def initialize(volume)
    super
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
