class User
  attr_accessor :name, :bank, :cards

  def initialize(name)
    @name = name
    @bank = 100
    @cards = 2
  end
end
