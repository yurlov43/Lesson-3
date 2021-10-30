class Train
  attr_accessor :speed
  attr_accessor :number_wagons
  attr_accessor :station
  attr_accessor :route
  attr_reader :number
  attr_reader :type

  def initialize(number, type = "cargo", number_wagons)
    @number = number
    @type = type
    @number_wagons = number_wagons
    @speed = 0
  end

  def accelerate(speed_gain = 10)
    if self.speed + speed_gain <= 70
      self.speed += speed_gain
    else
      self.speed = 70
    end
  end

  def braking(speed_decrease = self.speed)
    if self.speed > speed_decrease
      self.speed -= speed_decrease
    else
      self.speed = 0
    end
  end

  def attach_wagon
    self.number_wagons += 1 \
      if self.number_wagons <= 99 && self.speed == 0
  end

  def unhook_wagon
    self.number_wagons -= 1 \
      if self.number_wagons >= 1 && self.speed == 0
  end

  def add_route(route)
    self.route = route
    self.station = self.route.start_station
    self.station.take_train(self)
    nil
  end

  def position_in_route
    current_index = self.route.stations.flatten.index(self.station)

    if self.station == self.route.start_station
      puts "\tStation: #{self.route.start_station.title} << Route start"
    else
      puts "\tStation: #{self.route.stations.flatten[current_index - 1].title} << Previous station"
    end

    if self.station != self.route.start_station &&
      self.station != self.route.end_station
      puts "\tStation: #{self.station.title} << Current position"
    end

    if self.station == self.route.end_station
      puts "\tStation: #{self.route.end_station.title} << End station"
    else
      puts "\tStation: #{self.route.stations.flatten[current_index + 1].title} << next station"
    end
  end

  def moving_forward
    current_index = self.route.stations.flatten.index(self.station)
    if self.station == self.route.end_station
      puts "End of the route. There are no stations ahead."
    else
      self.station.send_train(self)
      self.station = self.route.stations.flatten[current_index + 1]
      self.station.take_train(self)
      puts "The train arrived at the station: #{self.station.title}"
    end
  end

  def move_back
    current_index = self.route.stations.flatten.index(self.station)
    if self.station == self.route.start_station
      puts "The beginning of the route. There are no stations behind."
    else
      self.station.send_train(self)
      self.station = self.route.stations.flatten[current_index - 1]
      self.station.take_train(self)
      puts "The train returned to the station: #{self.station.title}"
    end
  end
end