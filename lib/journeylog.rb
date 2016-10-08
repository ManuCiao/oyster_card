require 'forwardable'

class JourneyLog

  extend Forwardable

  def_delegator :current_journey, :finish, :end_journey
  attr_reader :journey_class


  def initialize(journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def begin_journey(station)
    raise "Currently in journey" if double_entry?
    update_journey(journey_class.new(entry_station: station))
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey
    journeys.reject(&:complete?).first || journey_class.new
  end

  def update_journey(journey)
    @journeys << journey
  end

  def double_entry?
    current_journey.entry_station
  end
end
