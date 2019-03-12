require "oystercard"

describe Oystercard do
  before(:each) do
    @card = Oystercard.new
  end
  
  let(:in_station){ double :in_station }
  let(:out_station){ double :out_station }

  it { is_expected.to respond_to(:balance) } 
  it { is_expected.to respond_to(:top_up) }

  it "returns a starting balance of 0" do
    expect(@card.balance).to eq 0
  end

  it "should have a balance of 10 when user tops up 10" do
    @card.top_up(10)
    expect(@card.balance).to eq 10
  end

  it "increases balance by top up amount" do 
    @card.top_up(10)
    @card.top_up(20)
    expect(@card.balance).to eq 30
  end
  
  it "allows top up to 1 below limit amount" do
    limit = Oystercard::DEFAULT_LIMIT
    expect(@card.top_up(limit - 1)).to eq limit - 1
  end

  it "has a default limit of £90" do
    limit = Oystercard::DEFAULT_LIMIT
    error = "Top-up exceeds £#{limit} balance limit. Add lower amount."
    @card.top_up(1)
    expect { @card.top_up(limit) }.to raise_error error
  end
  
  it { is_expected.to respond_to(:touch_in) }

  it "should show in journey as false at first" do
    expect(@card).to_not be_in_journey
  end

  it "should change in journey status to true when card touched in" do
    @card.top_up(5)
    @card.touch_in(in_station)
    expect(@card).to be_in_journey
  end

  it "should change in journey status to false when card touched out" do
    @card.top_up(5)
    @card.touch_in(in_station)
    @card.touch_out(out_station)
    expect(@card).to_not be_in_journey
  end

  it "should have a minimum balance for a single journey" do
    expect { @card.touch_in(in_station) }.to raise_error "Insufficient funds"
  end

  it "should deduct fare from balance" do
    @card.top_up(5)
    @card.touch_in(in_station)
    fare = Oystercard::MINIMUM_FARE

    expect {@card.touch_out(out_station)}.to change{@card.balance}.by(- fare)
  end

  it "should record journey entry station" do
    @card.top_up(5)
    expect {@card.touch_in(in_station)}.to change{@card.entry_station}.to(in_station)
  end

  it "should set entry_station to nil on touch_out" do
    @card.top_up(10)
    @card.touch_in(in_station)
    @card.touch_out(out_station)
    expect(@card.entry_station).to eq nil
  end

  it "should record journey exit station" do
    @card.touch_out(out_station)
    expect(@card.exit_station).to eq out_station
  end

  it "should create a new card with an empty list of journeys" do
    expect(@card.list_of_journeys).to eq []
  end

  it "should create a journey after touching in and out" do
    @card.top_up(10)
    @card.touch_in(in_station)
    @card.touch_out(out_station)
    expect(@card.list_of_journeys).to eq [{in_station => out_station}]
  end
end