class PassengerWagon
  def initialize
    @type = 'passenger'
  end

  def passenger(train)
    if train.train_type == 'passenger'
      puts true
    end
  end
end