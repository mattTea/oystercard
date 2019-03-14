require "journey"

describe Journey do
  let(:journey) { Journey.new("A") }

  it "returns new journey on touch_in" do
    expect(journey).to be_instance_of Journey
  end

  it "contains entry_station" do
    expect(journey.entry_station).to eq "A"
  end

  it "contains exit_station" do
    expect(journey.exit_station).to eq "Unknown"
  end

  it "contains a fare" do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end
end