# frozen_string_literal: true

require_relative 'modules/company'

class Wagon
  include Company

  attr_reader :type

  def initialize(type, company)
    @type = type
    self.company_name = company
  end
end
