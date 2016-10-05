require 'station'

describe Station do

 it "returns the name of the station" do
   station = Station.new("Euston", 1)
   expect(station.name).to eq "Euston"
 end

 it "returns the zone of the station" do
   station = Station.new("Euston", 1)
   expect(station.zone).to eq 1
 end

end
