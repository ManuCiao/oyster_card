require 'journeylog'
require "Journey"

describe JourneyLog do

  subject(:journeylog){described_class.new(journey_class: journey_class)}
  let(:journey) {double :journey}
  let(:station){ double :station }
  let(:journey_class){double :journey_class, new: journey}

  context "initialize" do
    it "returns an empty journey log array" do
      expect(subject.journeys).to eq []
    end
  end

  context "#begin_journey" do
    it "returns the journey has been started" do
      expect(journey_class).to receive(:new).with(station)
      subject.begin_journey(station)
    end

    it "keep track of the journey" do
      expect(journey_class).to receive(:new) {journey}
      subject.begin_journey(station)
      expect(subject.journeys).to include journey
    end

    it "returns an error when the journey has been already started" do
      expect{subject.begin_journey(station)}.to raise_error "Currently in journey"
    end
  end

  context "#end_journey" do
    it "returns finish journey recorded in the journeys log" do
      subject.current_journey = journey
      subject.end_journey
      expect(subject.journeys.last).to eq journey
    end

    it "reset the list of journeys at the end of the last journey" do
      subject.current_journey = journey
      subject.end_journey
      expect(subject.current_journey).to have_attributes(entry_station: nil, exit_station: nil)
    end
  end
  end

end
