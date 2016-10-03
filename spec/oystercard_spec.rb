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
      subject.top_up(Oystercard::LIMIT)
      expect { subject.top_up(100)}.to raise_error("Cannot top up the amount as your limit has been reached!!")
    end

  end


end
