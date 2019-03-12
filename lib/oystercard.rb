class Oystercard
  attr_reader :balance
  attr_reader :entry_station

  DEFAULT_LIMIT = 90
  MINIMUM = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Top-up exceeds £#{DEFAULT_LIMIT} balance limit. Add lower amount." if @balance + amount > DEFAULT_LIMIT
      
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM

    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    true if @entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
