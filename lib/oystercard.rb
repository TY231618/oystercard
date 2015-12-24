class Oystercard

MAX_BALANCE = 99
attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "You have reached your top up limit of £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def tap_in
    @in_journey = true
  end

  def tap_out
    @in_journey = false
  end
end
