class Oystercard
MAX_LIMIT = 90
MIN_LIMIT = 1
attr_reader :balance, :in_journey

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    raise "Cannot top up the amount as your limit has been reached!!" if amount + @balance > MAX_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail "Cannot touch in if you do not have the minimum fare available!!" if @balance > MIN_LIMIT
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
