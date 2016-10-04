require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe "initialization" do
    it "returns oystercard with balance equal 0" do
      expect(subject.balance).to eq 0
    end

  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument}

    it "accept a top up" do
      expect{ subject.top_up 10 }.to change{ subject.balance }.by 10
    end

    it "raise an error when the balance limit is reached" do
      subject.top_up(Oystercard::MAX_LIMIT)
      expect { subject.top_up(100)}.to raise_error("Cannot top up the amount as your limit has been reached!!")
    end

  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in).with(0).argument}
    xit "returns that you are in journey" do
      expect(subject.touch_in).to eq true
    end
    it 'return it will not touch in when below minimum balance' do
      allow(subject).to receive(:balance) {0}
      expect{ subject.touch_in }.to raise_error("Cannot touch in if you do not have the minimum fare available!!" )
    end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out).with(0).argument}
    it "returns that you have finished the journey" do
      expect(subject.touch_out).to eq false
    end
  end



end
