class Oystercard

  attr_reader :balance, :journeylog

  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize(journeylog: JourneyLog.new) # to create a new journeylog as a default
    @balance = 0
    @journeylog = journeylog
  end

  def top_up(amount)
    raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_BALANCE
    journeylog.begin_journey(station)
  end

  def touch_out(station)
    journey = journeylog.end_journey(station)
    deduct(journey.fare)
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
