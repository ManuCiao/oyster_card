require 'oystercard'

describe Oystercard do
let(:station) { double :station }
let(:entry_station) { double :station }
let(:exit_station) { double :station }
let(:journeys) {{:entry_station => entry_station, :exit_station => exit_station}}
 before(:each) do
  @oystercard = Oystercard.new
 end

 it "returns an empty list of journeys" do
   expect(@oystercard.journeys).to be_empty
 end
 it 'has a starting balance of 0' do
   expect(@oystercard.balance).to eq(0)
 end

 context '#top_up' do
   it { is_expected.to respond_to(:top_up).with(1).argument }

   it 'can top up the balance' do
     expect{ @oystercard.top_up(0) }.to change{ @oystercard.balance }.by 0
   end

   it 'enforces maximum balance' do
     @oystercard.top_up(Oystercard::MAX_BALANCE)
     expect{ @oystercard.top_up(100) }.to raise_error "Maximum balance of 90 exceeded"
   end
 end

  context '#touch_in' do
    it 'is currently in journey' do
      @oystercard.top_up(2)
      @oystercard.touch_in(station)
      expect(@oystercard.entry_station).to eq station
    end
    it 'enforces minimum fare of 2' do
      expect{ @oystercard.touch_in(station) }.to raise_error "Insufficient balance"
  end
end

  context '#touch_out' do
    it 'is not currently in journey' do
      @oystercard.top_up(2)
      @oystercard.touch_in(station)
      @oystercard.touch_out(exit_station)
      expect(@oystercard.entry_station).to eq nil
    end
    it "checks for minimum balance on oystercard" do
      @oystercard.top_up(2)
      expect { @oystercard.touch_out(exit_station) }.to change{ @oystercard.balance }.by (-Oystercard::MIN_FARE)
    end
  end

 end
