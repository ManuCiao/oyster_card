require_relative 'journey'

class JourneyLog

attr_reader :journey_class, :journeys
attr_accessor :current_journey

  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def begin_journey(station)
    raise "Currently in journey" if double_entry?
    update_journey(journey_class.new(entry_station: station))
  end

  def end_journey(station)
    update_journey(current_journey.exit_station)
    reset_journey
  end

  def journeys
    @journeys.dub
  end

  private

  def current_journey
    !@current_journey.complete? || journey_class.new
  end

  def reset_journey
    @current_journey = Journey.new
  end

  def update_journey(journey)
    @journeys << journey
  end

  def double_entry?
    current_journey.entry_station != nil
  end
end
