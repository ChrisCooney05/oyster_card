require_relative 'station'
require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station

  LIMIT = 90
  LOW = 1

  def initialize
    @balance = 0
    @journeys = Journey.new
  end

  def top_up(value)
    raise "Maximum balance is £#{LIMIT}, current balance is £#{@balance}" if balance_check_over?(value)

    @balance += value
  end

  def in_journey?
    @journeys.in_journey?
  end

  def touch_in(station)
    raise "Insufficient funds, current balance £#{@balance}. Minimum balance to travel £#{LOW}" if balance_check_under?

    @journeys.touch_in(station)
  end

  def touch_out(station)
    deduct
    @journeys.touch_out(station)
  end

  def trip_history
    @journeys.trip_history
  end

  private

  def deduct(value = Journey::MIN_FARE)
    @balance -= value
  end

  def balance_check_over?(value)
    @balance + value > LIMIT
  end

  def balance_check_under?
    @balance < LOW
  end

end
