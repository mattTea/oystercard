require "oystercard"

describe Oystercard do
  let(:card) { Oystercard.new }
  
  let(:in_station) { double :in_station }
  let(:out_station) { double :out_station }

  context "when topping up the card with £10" do
    before { card.top_up(10) }

    it "has a balance of £10" do
      expect(card.balance).to eq 10
    end

    it "has a balance of £30 when topped up by another £20" do 
      card.top_up(20)
      expect(card.balance).to eq 30
    end
  end

  context "when using an empty card" do
    let(:limit) { Oystercard::DEFAULT_LIMIT }
    
    it "returns a starting balance of 0" do
      expect(card.balance).to eq 0
    end

    it "has no journeys recorded" do
      expect(card.show_journeys).to eq []
    end

    it "allows top up to £1 below limit amount" do
      expect(card.top_up(limit - 1)).to eq limit - 1
    end
  
    it "raises error when attempt to top up over limit is made" do
      error = "Top-up exceeds £#{limit} balance limit. Add lower amount."
      expect { card.top_up(limit + 1) }.to raise_error error
    end

    it "shows as not in journey" do
      expect(card).to_not be_in_journey
    end
  end

  context "at journey start" do
    it "raises an error when there isn't a minimum balance" do
      expect { card.touch_in(in_station) }.to raise_error "Insufficient funds"
    end

    it "records journey entry station" do
      card.top_up(10)
      expect {card.touch_in(in_station)}.to change{card.entry_station}.to(in_station)
    end
   
    context "when in a journey" do
      before do
        card.top_up(10)
        card.touch_in(in_station)
      end

      it "shows as in a journey" do
        expect(card).to be_in_journey
      end
    end
  end
  
  context "at journey completion" do
    before do
      card.top_up(10)
      card.touch_in(in_station)
    end

    it "deducts fare from balance" do
      fare = Oystercard::MINIMUM_FARE
      expect {card.touch_out(out_station)}.to change{card.balance}.by(- fare)
    end

    context "when journey has been completed" do
      before do
        card.touch_out(out_station)
      end
      
      it "shows as not in journey" do
        expect(card).to_not be_in_journey
      end

      it "shows the completed journey in a list" do
        expect(card.show_journeys).to include ({entry: in_station, exit: out_station})
      end
    end
  end  
end