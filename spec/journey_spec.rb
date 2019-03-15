require "journey"

describe Journey do
  it { is_expected.to respond_to(:calculate_fare) }

  it "calculates £1 minimum fare for complete journey" do
    journey = Journey.new("A", "B")
    expect(journey.calculate_fare).to eq Journey::MINIMUM_FARE
  end

  it "calculates £6 penalty fare for incomplete journey" do
    journey = Journey.new(nil, "B")
    expect(journey.calculate_fare).to eq Journey::PENALTY_FARE
  end

  it { is_expected.to respond_to(:complete?) }

  it "is complete if it has an entry and an exit station" do
    journey = Journey.new("A", "B")
    expect(journey.complete?).to be true
  end

  it "is not complete if it does not have an exit station" do
    journey = Journey.new("A")
    expect(journey.complete?).to be false
  end

  # it { is_expected.to respond_to(:update_journey) }

  it "updates incomplete journey" do
    
  end

  # it "returns new journey on touch_in" do
  #   expect(journey).to be_instance_of Journey
  # end

  # it "contains entry_station" do
  #   expect(journey.entry_station).to eq "A"
  # end

  # it "contains exit_station" do
  #   expect(journey.exit_station).to eq "Unknown"
  # end

  # it "contains a fare" do
  #   expect(journey.fare).to eq Journey::PENALTY_FARE
  # end
end