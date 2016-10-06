require "Oystercard.rb"

describe Oystercard do

  subject(:card) {described_class.new(journey_log: journey_log)}
  let(:station) {double :station}
  let(:journey){double :journey, fare: 6, complete?: true}
  let(:journeylog) {double :journeylog}

  it "returns list of journeys to be empty" do
    expect(card.journeys).to eq []
  end

  it "should have a balance of zero" do
    expect(card.balance).to eq 0
  end

  it "should top up the card" do
    card.top_up(5)
    expect(card.balance).to eq 5
  end

  it "should raise an error if the top up limit is reached" do
    maximum = Oystercard::MAXIMUM_LIMIT
    card.top_up(maximum)
    expect {card.top_up(1)}.to raise_error("The maximum top up value of #{maximum} has been reached!")
  end

  it "should check minimum balance" do
    expect {card.touch_in(station)}.to raise_error "Insufficient funds"
  end

  it "returns what station the card touched in at" do
    expect(journeylog).to receive(:begin_journey).with(station)
    card.touch_in(station)
  end

  it "returns journey log in which station the card touched out" do
    expect(journeylog).to receive(:end_journey).with(station)
    card.touch_out(station)
  end

  it "returns the charge deducted from the balance when touching out" do
   allow(journeylog).to receive(:begin_journey)
   card.touch_in(station)
   expect{card.touch_out(station)}.to change{card.balance}.by(-journey.fare)
  end

end
