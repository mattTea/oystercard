require_relative "journey"

class Oystercard
  # attr_reader :balance, :entry_station, :exit_station, :list_of_journeys, :incomplete_journey
  attr_reader :balance, :list_of_journeys, :incomplete_journey

  DEFAULT_LIMIT = 90
  MINIMUM = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @list_of_journeys = []
    @incomplete_journey = []
  end

  def top_up(amount)
    raise "Top-up exceeds £#{DEFAULT_LIMIT} balance limit. Add lower amount." if @balance + amount > DEFAULT_LIMIT
      
    @balance += amount
  end

  def touch_in(station, journey_class = Journey)
    raise "Insufficient funds" if @balance < MINIMUM
    new_journey = journey_class.new(station, nil)
    @incomplete_journey << new_journey
    deduct(new_journey.calculate_fare)
  end

  def touch_out(station, journey_class = Journey)
    if @incomplete_journey.empty?
      missing_touch_in_journey = journey_class.new(nil, station)
      @list_of_journeys << missing_touch_in_journey
      deduct(missing_touch_in_journey.calculate_fare)
    else
      refund = journey_class::PENALTY_FARE - journey_class::MINIMUM_FARE
      completed_journey = @incomplete_journey[0]
      completed_journey.update_journey(completed_journey.entry_station, station, completed_journey.fare - refund)
      deduct(- refund)
      @list_of_journeys << completed_journey
      @incomplete_journey = []
    end
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
