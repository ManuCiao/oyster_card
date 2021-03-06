require "journey"

describe Journey do

  subject(:journey){described_class.new(:station)}
  let(:station) {double('station', name: "Euston", zone: 1)}
  let(:station2) {double('station2', name: "Archway", zone: 2)}

  it "returns an entry station" do
    expect(journey.entry_station).to eq(:station)
  end

  it "should state that the journey has started" do
    expect(journey).not_to be_complete
  end

  context "#finish" do

    it "return a penalty if no exit station given" do
      journey.finish
      expect(journey.fare).to eq Journey::PENALTY
    end

    it "should state that the journey has completed" do
      journey.finish(station)
      expect(journey).to be_complete
    end

  end

  context "#fare" do

   it "returns the finish journey when exiting a journey" do
     expect(journey.finish(station)).to eq(journey)
   end

   it "return penalty fare when there is no entry station but there are 2 exit" do
     journey.finish
     expect(journey.fare).to eq Journey::PENALTY
   end

   it "return penalty fare when there is no entry station" do
     expect(journey.fare).to eq Journey::PENALTY
   end

  end

end
