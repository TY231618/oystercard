class Oystercard

MAX_BALANCE = 99
MIN_FARE = 1
attr_reader :balance, :entry_station, :exit_station, :current_journey, :journey_history

  def initialize
    @balance = 0
    @current_journey = []
    @journey_history = []
  end

  def top_up(amount)
    fail "You have reached your top up limit of £#{MAX_BALANCE}" if card_maxed_out?(amount)
    @balance += amount
  end

  def tap_in(station)
    fail 'Not enough money on card: please top up' if card_below_min_fare?
    @entry_station = station
    @current_journey << @entry_station
  end

  def tap_out(station)
    deduct(MIN_FARE)
    @exit_station = station
    @current_journey << @exit_station
    journey_log
  end

  def journey_log
    @journey_history << @current_journey
    @current_journey = []
  end

  private

  def card_maxed_out?(amount)
    @balance + amount > MAX_BALANCE
  end

  def card_below_min_fare?
    @balance < MIN_FARE
  end

  def deduct(amount)
    @balance -= amount
  end
end
