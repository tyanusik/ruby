# frozen_string_literal: true

require_relative 'modules/instance_counter'
require_relative 'modules/company'

class CargoTrain < Train
  include InstanceCounter
  include Company

  self.trains = []
end
