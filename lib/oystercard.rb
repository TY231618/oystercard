class Oystercard

MAX_BALANCE = 99
attr_reader :balance

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "You have reached your top up limit of £#{MAX_BALANCE}" if card_maxed_out?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_use
  end
  
  def tap_in
    @in_use = true
  end

  def tap_out
    @in_use = false
  end

  private

  def card_maxed_out?(amount)
    @balance + amount > MAX_BALANCE
  end
end
