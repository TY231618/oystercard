class Oystercard

MAX_BALANCE = 99
attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "You have reached your top up limit of £#{MAX_BALANCE}" if @balance + amount > MAX_BALANCE
    @balance += amount
  end
end
