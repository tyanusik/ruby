class User
  attr_accessor :name, :bank

  def initialize(name)
    @name = name
    @bank = 100
    @cards = []
  end
end
