class CargoWagon
  def initialize
    @type = 'cargo'
  end

  def cargo(train)
    if train.train_type == 'cargo'
      puts true
    end
  end
end