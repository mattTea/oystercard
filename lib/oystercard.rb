class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :list_of_journeys, :incomplete_journeys

  DEFAULT_LIMIT = 90
  MINIMUM = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @list_of_journeys = []
    @incomplete_journeys = []
  end

  def top_up(amount)
    raise "Top-up exceeds £#{DEFAULT_LIMIT} balance limit. Add lower amount." if @balance + amount > DEFAULT_LIMIT
      
    @balance += amount
  end

  def touch_in(station, journey_class = Journey)
    raise "Insufficient funds" if @balance < MINIMUM

    # set entry_station to station
    # create new journey
    # push new journey to incomplete_journeys
    incomplete_journeys << journey_class.new(station)

    @entry_station = station # <- sets in_journey? to true (not yet I don't think)
  end

  def touch_out(station)
    # check if incomplete_journeys has anything in it
    # if not      -> create a new journey
    #             -> calculate fare as PENALTY_FARE
    #             -> add journey to list_of_journeys

    # if there is -> set exit_station of that journey to station
    #             -> calculate fare as MINIMUM_FARE
    #             -> add journey to list_of_journeys
    #             -> delete journey from incomplete_journeys
    
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
