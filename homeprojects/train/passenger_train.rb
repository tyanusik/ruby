# frozen_string_literal: true

require_relative 'modules/instance_counter'

class PassengerTrain < Train
  include InstanceCounter

  self.trains = []
end
