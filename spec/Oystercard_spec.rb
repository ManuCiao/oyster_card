require "Oystercard.rb"

describe Oystercard do

  subject(:card) {described_class.new}
  let(:station) {double :station}
  let(:exit_station) {double :station}
  let(:entry_station) {double :station}
  #let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

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

xit 'should deduct the amount for the trip from balance' do
  card.top_up(15)
  card.deduct(10)
  expect(card.balance).to eq 5
end

it "should have the card remember the entry station name" do
  card.top_up(1)
  card.touch_in(station)
  expect(card.entry_station).to eq station
end

it "should see if a card has touched out" do
  card.touch_out(station)
  expect(card.in_journey?).to eq false
end

it "should check minimum balance" do
  # allow(card).to receive(:balance) {0}
  expect {card.touch_in(station)}.to raise_error "Insufficient funds"
end

it "should charge the card for the minimum fare" do
  card.top_up(15)
  card.touch_in(station)
  expect {card.touch_out(station)}.to change{card.balance}.by(-Oystercard::MINIMUM_FARE)
end

it "returns journey history" do
  card.top_up(5)
  card.touch_in(entry_station)
  card.touch_out(exit_station)
  journey = {entry_station: entry_station, exit_station: exit_station}
  expect(card.journeys).to include journey
end

end
