class Journey

  attr_reader :journeys

  MIN_FARE = 2
  PENALTY_FARE = 6

  def initialize
    @journeys = []
    @entry_station = nil
  end

  def touch_in(station)
    @entry_station = station
  end

  def in_journey?
    !@entry_station == nil
  end

  def touch_out(station)
    add_trip(station)
    @entry_station = nil
  end

  def fare
    PENALTY_FARE
  end


  def trip_history
    @journeys
  end

  def add_trip(station)
    @journeys << {entry: @entry_station, exit: station}
  end
end
