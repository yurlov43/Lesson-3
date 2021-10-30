class Train
  attr_accessor :speed
  attr_accessor :number_wagons
  attr_accessor :route
  attr_accessor :current_index
  attr_reader :number
  attr_reader :type

  def initialize(number, type = "cargo", number_wagons)
    @number = number
    @type = type
    @number_wagons = number_wagons
    @speed = 0
  end

  def accelerate(speed_gain = 10)
    self.speed + speed_gain <= 70 ?
      self.speed += speed_gain :
      self.speed = 70
  end

  def braking(speed_decrease = self.speed)
    self.speed > speed_decrease ?
      self.speed -= speed_decrease :
      self.speed = 0
  end

  def attach_wagon
    self.number_wagons += 1 if self.number_wagons <= 99 && self.speed == 0
  end

  def unhook_wagon
    self.number_wagons -= 1 if self.number_wagons >= 1 && self.speed == 0
  end

  def add_route(route)
    self.route = route
    self.current_index = 0
    self.route.stations.first.take_train(self)
    nil
  end

  def current_station
    self.route.stations.flatten[current_index]
  end

  def previous_station
    previous_index = current_index - 1
    self.route.stations.flatten[previous_index] if previous_index >= 0
  end

  def next_station
    self.route.stations.flatten[current_index + 1]
  end

  def position_in_route
    puts "\tStation: #{previous_station.title} " <<
           "- previous station" unless previous_station.nil?
    puts "\tStation: #{current_station.title} - current position"
    puts "\tStation: #{next_station.title} " <<
           "- next station" unless next_station.nil?
  end

  def move_back
    if previous_station.nil?
      puts "The beginning of the route. There are no stations behind."
    else
      current_station.send_train(self)
      self.current_index -= 1
      current_station.take_train(self)
      puts "The train returned to the station: #{current_station.title}"
    end
  end

  def moving_forward
    if next_station.nil?
      puts "End of the route. There are no stations ahead."
    else
      current_station.send_train(self)
      self.current_index += 1
      current_station.take_train(self)
      puts "The train arrived at the station: #{current_station.title}"
    end
  end
end