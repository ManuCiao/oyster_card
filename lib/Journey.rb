class Journey

 PENALTY = 6
 MINIMUM_FARE = 1

attr_accessor :entry_station, :exit_station

def initialize(entry_station = nil)
  @entry_station = entry_station
  @complete = false
end

def finish(station = nil)
  @exit_station = station
  @complete = true
  self
end

def fare
  (!entry_station || !exit_station)? PENALTY : zone_fare
end

def complete?
  @complete
end

def zone_fare
  (entry_station.zone - exit_station.zone).abs + MINIMUM_FARE
end

end
