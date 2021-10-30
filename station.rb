class Station
  attr_accessor :title
  attr_reader :trains

  def initialize(title)
    @title = title
    @trains = []
  end

  def take_train(train)
    trains << train if train.current_station == self
  end

  def trains_by_type
    puts "At the station: #{title}"
    freight_trains = trains.select do |train|
      train.type == "cargo"
    end

    puts "\t#{freight_trains.size} - freight trains."
    passenger_trains = trains.select do |train|
      train.type == "passenger"
    end
    puts "\t#{passenger_trains.size} - passenger trains"
  end

  def send_train(train)
    trains.delete(train)
  end
end