class Oystercard

  attr_reader :balance, :in_use

  LIMIT = 90
  LOW = 1
  MIN_FAIR = 2

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(value)
    raise "Maximum balance is £#{LIMIT}, current balance is £#{@balance}" if balance_check_over?(value)

    @balance += value
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise "Insufficient funds, current balance £#{@balance}. Minimum balance to travel £#{LOW}" if balance_check_under?

    @in_use = true
  end

  def touch_out
    deduct
    @in_use = false
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
