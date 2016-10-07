require_relative 'journey', 'journeylog'

class Oystercard

  attr_reader :balance, :journeys
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(journey_log: JourneyLog.new) # to create a new journeylog as a default
    @balance = 0
    @journey_log = journey_log
  end

  def top_up(amount)
    raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_BALANCE
    journey_log.begin_journey(station)
  end

  def touch_out(station)
    journey = journey_log.end_journey(station)
    deduct(journey.fare)
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
