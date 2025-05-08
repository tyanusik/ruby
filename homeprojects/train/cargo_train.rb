class CargoTrain < Train
  def add_wagons(wagon)
    if wagon.passenger == true
      super
    end
  end
end