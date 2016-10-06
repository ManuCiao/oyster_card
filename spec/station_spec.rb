require 'station'

describe Station do
  subject(:station) {described_class.new(name: "Euston", zone: 1)}

  it "returns the name of the station" do
   expect(station.name).to eq "Euston"
  end

  it "returns the zone of the station" do
   expect(station.zone).to eq 1
  end

end
