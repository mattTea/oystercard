class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :list_of_journeys

  DEFAULT_LIMIT = 90
  MINIMUM = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @list_of_journeys = []
  end

  def top_up(amount)
    raise "Top-up exceeds £#{DEFAULT_LIMIT} balance limit. Add lower amount." if @balance + amount > DEFAULT_LIMIT
      
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM

    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    
    @exit_station = station
    @list_of_journeys << { @entry_station => @exit_station }
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
