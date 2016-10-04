class Oystercard
MAX_LIMIT = 90
MIN_LIMIT = 1
DEFAULT_BALANCE = 0
attr_reader :balance, :in_journey

  def initialize(balance = DEFAULT_BALANCE, limit = MAX_LIMIT)
    @balance = balance
    @limit = limit
    @in_journey = false
    @min_fare = MIN_LIMIT
  end

  def top_up(amount)
    raise "Cannot top up the amount as your limit has been reached!!" if amount + @balance > @limit
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Cannot touch in if you do not have the minimum fare available!!" if @balance < @min_fare
    @in_journey = true
  end

  def touch_out
    deduct(@min_fare)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
