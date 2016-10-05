require_relative "Oystercard.rb"

class Journey

 PENALTY = 6

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
  return PENALTY if (!entry_station || !exit_station)
end

def complete?
    @complete
end

end
