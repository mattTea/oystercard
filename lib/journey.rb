class Journey
  attr_reader :entry_station, :exit_station, :fare

  PENALTY_FARE = 6

  def initialize(entry_station = "Unknown", exit_station = "Unknown", fare = PENALTY_FARE)
    @entry_station = entry_station
    @exit_station = exit_station
    @fare = fare
  end
end