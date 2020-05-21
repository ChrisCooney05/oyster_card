class Oystercard

  attr_reader :balance, :entry_station, :journeys

  LIMIT = 90
  LOW = 1
  MIN_FAIR = 2

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(value)
    raise "Maximum balance is £#{LIMIT}, current balance is £#{@balance}" if balance_check_over?(value)

    @balance += value
  end

  def in_journey?
    !@entry_station == nil
  end

  def touch_in(station)
    raise "Insufficient funds, current balance £#{@balance}. Minimum balance to travel £#{LOW}" if balance_check_under?

    @entry_station = station
  end

  def touch_out
    deduct
    @entry_station = nil
  end

  private

  def deduct(value = MIN_FAIR)
    @balance -= value
  end

  def balance_check_over?(value)
    @balance + value > LIMIT
  end

  def balance_check_under?
    @balance < LOW
  end

end
