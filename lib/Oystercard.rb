require_relative "Journey.rb"

class Oystercard

  attr_reader :balance, :journeys
  MAXIMUM_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "The maximum top up value of #{MAXIMUM_LIMIT} has been reached!" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds" if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    list_journeys(station)
    @entry_station = nil
  end

  def list_journeys(station)
    journey = {:entry_station => @entry_station, :exit_station => station}
    @journeys << journey
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
