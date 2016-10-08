require 'journeylog'
require 'journey'

describe JourneyLog do

  subject(:journeylog){described_class.new(journey_class: journey_class)}
  let(:journey) {double :journey, entry_station: nil, complete?: false }
  let(:station){ double :station }
  let(:journey_class){double :journey_class, new: journey}

  context "initialize" do
    it "returns an empty journey log array" do
      expect(subject.journeys).to eq []
    end
  end

  context "#begin_journey" do
    it "returns the journey has been started" do
      expect(journey_class).to receive(:new).with(entry_station: station)
      subject.begin_journey(station)
    end

    it "keep track of the journey" do
      expect(journey_class).to receive(:new) {journey}
      subject.begin_journey(station)
      expect(subject.journeys).to include journey
    end

    it "returns an error when the journey has been already started" do
      journeylog.begin_journey(station)
      allow(journey).to receive(:entry_station).and_return(station)
      expect{subject.begin_journey(station)}.to raise_error "Currently in journey"
    end

  end

  it 'stops a current journey' do
    allow(journey_class).to receive(:new).and_return(journey)
    journeylog.begin_journey(station)
    expect(journey).to receive(:finish).with(station)
    journeylog.end_journey(station)
  end

  it 'returns a journey when there is no current journey' do
    expect(journey_class).to receive(:new).and_return(journey)
    allow(journey).to receive(:finish).with(station)
    journeylog.end_journey(station)
  end

  it "returns a new journey when finish the current journey" do
    allow(journey_class).to receive(:new).and_return journey
    allow(journey).to receive(:finish).with(station).and_return(journey)
    expect(journeylog.end_journey(station)).to eq journey
  end


end
