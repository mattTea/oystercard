class Oystercard
  attr_reader :balance, :entry_station, :exit_station # :list_of_journeys

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
    add_journey
    @entry_station = nil
  end

  def in_journey?
    true if @entry_station
  end

  def show_journeys
    @list_of_journeys
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def add_journey
    @list_of_journeys << { entry: @entry_station, exit: @exit_station }
  end
end
