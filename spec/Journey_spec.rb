require "Journey.rb"

describe Journey do

  subject(:journey){described_class.new(:station)}
  let(:station) {double :station}

  it "returns an entry station" do
    expect(journey.entry_station).to eq(:station)
  end

  it "should state that the journey has started" do
    expect(journey).not_to be_complete
  end

  describe "#fare" do

    it "should charge the penalty if no exit station given" do
      journey.finish
      expect(journey.fare).to eq Journey::PENALTY
    end

    it "returns the finish journey when exiting a journey" do
      expect(journey.finish(station)).to eq(journey)
    end

  end

  describe "#finish" do

    it "return a penalty if no exit station given" do
      journey.finish
      expect(journey.fare).to eq Journey::PENALTY
    end

    it 'return minimum fare charged when journey is been completed' do
      journey.finish(:station)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it "should state that the journey has completed" do
      journey.finish(station)
      expect(journey).to be_complete
    end

  end

end
