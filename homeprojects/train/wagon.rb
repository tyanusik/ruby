# frozen_string_literal: true

class Wagon
  attr_accessor :number

  def initialize(number, type, company, _capacity)
    @number = number
    @type = type
    @company = company
  end
end
