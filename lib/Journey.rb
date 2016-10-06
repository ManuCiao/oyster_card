require_relative 'Oystercard'

class Journey

 PENALTY = 6
 MINIMUM_FARE = 1


attr_reader :entry_station, :exit_station

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
  (!entry_station || !exit_station)? PENALTY : MINIMUM_FARE
end

def complete?
  @complete
end

end
