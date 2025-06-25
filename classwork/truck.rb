# frozen_string_literal: true

class Truck < Car
  def loading; end

  protected

  def initial_rpm
    500
  end
end
