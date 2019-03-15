class Journey
  attr_reader :entry_station, :exit_station, :fare

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  # def initialize(entry_station = nil, exit_station = nil, fare = PENALTY_FARE)
  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    # @fare = fare
  end

  def calculate_fare
    return @fare = PENALTY_FARE if @entry_station == nil || @exit_station == nil

    @fare = MINIMUM_FARE
  end

  def update_journey(entry_station, exit_station, fare)
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = fare
  end

  def complete?
    return false if @entry_station == nil || @exit_station == nil

    true
  end
end