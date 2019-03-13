require "station"

describe Station do
  let(:zone) { 2 }
  let(:station_name) { "Kilburn" }
  let(:station) { Station.new(station_name, zone) }
  
  # it { is_expected.to respond_to(:zone) }

  it "returns station zone of 2" do
    expect(station.zone).to eq zone
  end

  it "returns station zone of 5" do
    expect(Station.new("name", 5).zone).to eq 5
  end

  it "returns the name of a station" do
    expect(station.name).to eq station_name
  end

end